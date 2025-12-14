import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/user_role.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Update user role (admin only)
  Future<void> updateUserRole(String uid, UserRole newRole) async {
    await _firestore.collection('users').doc(uid).update({
      'role': newRole.name,
    });
  }

  // Update user profile
  Future<void> updateUserProfile({
    required String uid,
    String? fullName,
    String? phoneNumber,
  }) async {
    final Map<String, dynamic> updates = {};

    if (fullName != null) updates['fullName'] = fullName;
    if (phoneNumber != null) updates['phoneNumber'] = phoneNumber;

    if (updates.isNotEmpty) {
      await _firestore.collection('users').doc(uid).update(updates);
    }
  }

  // Get user by ID
  Future<UserModel?> getUserById(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (!doc.exists) return null;
      return UserModel.fromJson(doc.data()!);
    } catch (e) {
      print('Error getting user: \$e');
      return null;
    }
  }

  // Get user by email
  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) return null;

      return UserModel.fromJson(querySnapshot.docs.first.data());
    } catch (e) {
      print('Error getting user by email: \$e');
      return null;
    }
  }

  // Get all users by role (admin only)
  Future<List<UserModel>> getUsersByRole(UserRole role) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: role.name)
          .get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error getting users by role: \$e');
      return [];
    }
  }

  // Delete user (admin only)
  Future<void> deleteUser(String uid) async {
    await _firestore.collection('users').doc(uid).delete();
  }

  // Check if user is admin
  Future<bool> isAdmin(String uid) async {
    final user = await getUserById(uid);
    return user?.role == UserRole.admin;
  }
}
