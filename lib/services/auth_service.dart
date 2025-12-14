import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../models/user_model.dart';
import '../models/user_role.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Get current user stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Generate 6-digit OTP
  String _generateOTP() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  // Send OTP via email (using Gmail SMTP)
  Future<bool> sendOTPEmail(String email, String otp) async {
    if (kIsWeb) {
      print('----------------------------------------');
      print(
        'WEB DEMO MODE: Email sending is not supported on web client-side.',
      );
      print('OTP for $email is: $otp');
      print('----------------------------------------');
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      return true;
    }

    try {
      // SMTP Configuration
      final String username =
          'michael.mutemi16@gmail.com'; // MaryAir email account
      final String password = 'otzy otfa emms ksfr';

      final smtpServer = gmail(username, password);

      final message = Message()
        ..from = Address('michael.mutemi16@gmail.com', 'MaryAir Operations')
        ..recipients.add(email)
        ..subject = 'MaryAir - Verification Code'
        ..html =
            '''
          <div style="font-family: 'Helvetica Neue', Arial, sans-serif; max-width: 600px; margin: 0 auto; background-color: #000000; padding: 40px; border-radius: 12px; border: 1px solid #333;">
            <div style="text-align: center; margin-bottom: 30px;">
              <h1 style="color: #FFFFFF; margin: 0; font-size: 32px; letter-spacing: 2px;">MaryAir</h1>
              <p style="color: #FF4500; margin: 5px 0 0; font-style: italic;">Where quality meets affordability</p>
            </div>
            
            <div style="background-color: #111111; padding: 30px; border-radius: 8px; border: 1px solid #00FF00; text-align: center;">
              <p style="color: #CCCCCC; font-size: 16px; margin-bottom: 20px;">Use the following code to complete your verification:</p>
              <div style="background-color: #000; display: inline-block; padding: 15px 30px; border-radius: 8px; border: 1px dashed #FF4500;">
                <span style="color: #00FF00; font-size: 36px; font-weight: bold; letter-spacing: 8px;">$otp</span>
              </div>
              <p style="color: #888888; font-size: 14px; margin-top: 20px;">Valid for 10 minutes</p>
            </div>
            
            <div style="text-align: center; margin-top: 30px; border-top: 1px solid #333; padding-top: 20px;">
              <p style="color: #666; font-size: 12px;">&copy; 2024 MaryAir. All rights reserved.</p>
            </div>
          </div>
        ''';

      await send(message, smtpServer);
      return true;
    } catch (e) {
      print('Error sending OTP email: $e');
      return false;
    }
  }

  // Store OTP in Firestore
  Future<void> _storeOTP(String email, String otp) async {
    await _firestore.collection('otp_codes').doc(email).set({
      'otp': otp,
      'createdAt': FieldValue.serverTimestamp(),
      'expiresAt': DateTime.now().add(const Duration(minutes: 10)),
    });
  }

  // Verify OTP
  Future<bool> verifyOTP(String email, String otp) async {
    try {
      final doc = await _firestore.collection('otp_codes').doc(email).get();

      if (!doc.exists) {
        return false;
      }

      final data = doc.data()!;
      final storedOTP = data['otp'] as String;
      final expiresAt = (data['expiresAt'] as Timestamp).toDate();

      if (DateTime.now().isAfter(expiresAt)) {
        // OTP expired
        await _firestore.collection('otp_codes').doc(email).delete();
        return false;
      }

      if (storedOTP == otp) {
        // OTP is valid, delete it
        await _firestore.collection('otp_codes').doc(email).delete();
        return true;
      }

      return false;
    } catch (e) {
      print('Error verifying OTP: $e');
      return false;
    }
  }

  // Register with email and password
  // Initiate Registration (Send OTP only)
  Future<bool> initiateRegistration({required String email}) async {
    try {
      final otp = _generateOTP();
      await _storeOTP(email, otp);
      final emailSent = await sendOTPEmail(email, otp);

      if (!emailSent) {
        print('Warning: Failed to send OTP email to $email');
        return false;
      }
      return true;
    } catch (e) {
      print('Error initiating registration: $e');
      return false;
    }
  }

  // Complete Registration (Verify OTP and Create User)
  Future<UserModel?> completeRegistration({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
    required String otp,
  }) async {
    try {
      // 1. Verify OTP
      final isOtpValid = await verifyOTP(email, otp);
      if (!isOtpValid) {
        print('Invalid OTP during registration completion');
        return null;
      }

      // 2. Create User in Firebase Auth
      print('DEBUG: Attempting to create user in Firebase Auth...');
      print('DEBUG: App Name: ${_auth.app.name}');
      print('DEBUG: Project ID: ${_auth.app.options.projectId}');
      print('DEBUG: API Key: ${_auth.app.options.apiKey}');

      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) return null;

      // 3. Create User Model
      // Check if this is one of the first 2 users
      UserRole initialRole = UserRole.customer;
      try {
        final usersSnapshot = await _firestore
            .collection('users')
            .count()
            .get();
        final userCount = usersSnapshot.count ?? 0;
        if (userCount < 2) {
          initialRole = UserRole.admin;
        }
      } catch (e) {
        print('Error checking user count: $e');
        // Fallback or ignore, default to customer
      }

      final userModel = UserModel(
        uid: user.uid,
        email: email,
        fullName: fullName,
        phoneNumber: phoneNumber,
        role: initialRole,
        isEmailVerified: true, // Auto-verified
        createdAt: DateTime.now(),
      );

      // 4. Store User Data in Firestore
      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(userModel.toJson());

      return userModel;
    } on FirebaseAuthException catch (e) {
      print('Registration error: ${e.code}');
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  // Login with email and password
  Future<UserModel?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) return null;

      // Get user data from Firestore
      final doc = await _firestore.collection('users').doc(user.uid).get();

      if (!doc.exists) return null;

      final userModel = UserModel.fromJson(doc.data()!);

      // Update last login time
      await _firestore.collection('users').doc(user.uid).update({
        'lastLoginAt': FieldValue.serverTimestamp(),
      });

      return userModel;
    } on FirebaseAuthException catch (e) {
      print('Login error: \${e.code}');
      rethrow;
    } catch (e) {
      print('Unexpected error: \$e');
      rethrow;
    }
  }

  // Mark email as verified
  Future<void> markEmailVerified(String uid) async {
    await _firestore.collection('users').doc(uid).update({
      'isEmailVerified': true,
    });
  }

  // Resend OTP
  Future<bool> resendOTP(String email) async {
    try {
      final otp = _generateOTP();
      await _storeOTP(email, otp);
      return await sendOTPEmail(email, otp);
    } catch (e) {
      print('Error resending OTP: \$e');
      return false;
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get user data
  Future<UserModel?> getUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (!doc.exists) return null;
      return UserModel.fromJson(doc.data()!);
    } catch (e) {
      print('Error getting user data: \$e');
      return null;
    }
  }
}
