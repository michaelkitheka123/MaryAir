import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  AuthProvider() {
    _initializeAuth();
  }

  // Initialize authentication state
  Future<void> _initializeAuth() async {
    final user = _authService.currentUser;
    if (user != null) {
      _currentUser = await _authService.getUserData(user.uid);
      notifyListeners();
    }
  }

  // Register
  Map<String, dynamic>? _pendingRegistrationData;

  // Initiate Registration (Store data & Send OTP)
  Future<bool> initiateRegistration({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
  }) async {
    try {
      _setLoading(true);
      _errorMessage = null;

      // Store data temporarily
      _pendingRegistrationData = {
        'email': email,
        'password': password,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
      };

      final success = await _authService.initiateRegistration(email: email);

      _setLoading(false);
      return success;
    } catch (e) {
      _setLoading(false);
      _errorMessage = 'Failed to initiate registration';
      _pendingRegistrationData = null; // Clear on failure
      notifyListeners();
      return false;
    }
  }

  // Complete Registration (Verify OTP & Create Account)
  Future<bool> completeRegistration({required String otp}) async {
    try {
      if (_pendingRegistrationData == null) {
        _errorMessage = 'Registration session expired';
        notifyListeners();
        return false;
      }

      _setLoading(true);
      _errorMessage = null;

      _currentUser = await _authService.completeRegistration(
        email: _pendingRegistrationData!['email'],
        password: _pendingRegistrationData!['password'],
        fullName: _pendingRegistrationData!['fullName'],
        phoneNumber: _pendingRegistrationData!['phoneNumber'],
        otp: otp,
      );

      _setLoading(false);

      if (_currentUser != null) {
        _pendingRegistrationData = null; // Clear on success
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _handleAuthException(e);
      return false;
    } catch (e) {
      _setLoading(false);
      _errorMessage = 'An unexpected error occurred';
      notifyListeners();
      return false;
    }
  }

  // Login
  Future<bool> login({required String email, required String password}) async {
    try {
      _setLoading(true);
      _errorMessage = null;

      _currentUser = await _authService.loginWithEmail(
        email: email,
        password: password,
      );

      _setLoading(false);
      return _currentUser != null;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _handleAuthException(e);
      return false;
    } catch (e) {
      _setLoading(false);
      _errorMessage = 'An unexpected error occurred';
      notifyListeners();
      return false;
    }
  }

  // Verify OTP
  Future<bool> verifyOTP(String email, String otp) async {
    try {
      _setLoading(true);
      _errorMessage = null;

      final isValid = await _authService.verifyOTP(email, otp);

      if (isValid && _currentUser != null) {
        await _authService.markEmailVerified(_currentUser!.uid);
        _currentUser = _currentUser!.copyWith(isEmailVerified: true);
      }

      _setLoading(false);
      return isValid;
    } catch (e) {
      _setLoading(false);
      _errorMessage = 'Failed to verify OTP';
      notifyListeners();
      return false;
    }
  }

  // Resend OTP
  Future<bool> resendOTP(String email) async {
    try {
      _setLoading(true);
      _errorMessage = null;

      final success = await _authService.resendOTP(email);

      _setLoading(false);
      return success;
    } catch (e) {
      _setLoading(false);
      _errorMessage = 'Failed to resend OTP';
      notifyListeners();
      return false;
    }
  }

  // Send password reset email
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      _setLoading(true);
      _errorMessage = null;

      await _authService.sendPasswordResetEmail(email);

      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _handleAuthException(e);
      return false;
    } catch (e) {
      _setLoading(false);
      _errorMessage = 'Failed to send reset email';
      notifyListeners();
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _authService.signOut();
    _currentUser = null;
    _errorMessage = null;
    notifyListeners();
  }

  // Refresh user data
  Future<void> refreshUserData() async {
    final user = _authService.currentUser;
    if (user != null) {
      _currentUser = await _authService.getUserData(user.uid);
      notifyListeners();
    }
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Private helpers
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        _errorMessage = 'This email is already registered';
        break;
      case 'invalid-email':
        _errorMessage = 'Invalid email address';
        break;
      case 'operation-not-allowed':
        _errorMessage = 'Operation not allowed';
        break;
      case 'weak-password':
        _errorMessage = 'Password is too weak';
        break;
      case 'user-disabled':
        _errorMessage = 'This account has been disabled';
        break;
      case 'user-not-found':
        _errorMessage = 'No account found with this email';
        break;
      case 'wrong-password':
        _errorMessage = 'Incorrect password';
        break;
      case 'invalid-credential':
        _errorMessage = 'Invalid email or password';
        break;
      default:
        _errorMessage = 'Authentication error: ${e.message}';
    }
    notifyListeners();
  }
}
