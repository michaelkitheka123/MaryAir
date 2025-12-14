import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_role.dart';
import '../models/parcel_model.dart';
import '../models/user_model.dart';

class AdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch Dashboard Stats
  Future<Map<String, dynamic>> getDashboardStats() async {
    double totalRevenue = 0.0;
    int activeFlightsCount = 0;
    int newUsersCount = 0;
    Set<String> flightIds = {};

    try {
      // 1. Calculate Revenue from Bookings
      // Assuming 'bookings' collection where each doc has a 'price' field
      // Note: In a real scalable app, we'd use Cloud Functions to aggregate this.
      final bookingsSnapshot = await _firestore.collection('bookings').get();
      for (var doc in bookingsSnapshot.docs) {
        final data = doc.data();
        // Handle price which might be int or double
        final price = (data['price'] ?? 0);
        totalRevenue += price is int ? price.toDouble() : (price as double);

        if (data['flightNumber'] != null) {
          flightIds.add(data['flightNumber']);
        }
      }

      // 2. Calculate Revenue from Parcels
      final parcelsSnapshot = await _firestore.collection('parcels').get();
      for (var doc in parcelsSnapshot.docs) {
        final data = doc.data();
        final cost = (data['cost'] ?? 0);
        totalRevenue += cost is int ? cost.toDouble() : (cost as double);

        if (data['flightNumber'] != null) {
          flightIds.add(data['flightNumber']);
        }
      }

      activeFlightsCount = flightIds.length;

      // 3. New Users (Last 30 days)
      final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
      final usersSnapshot = await _firestore
          .collection('users')
          .where('createdAt', isGreaterThanOrEqualTo: thirtyDaysAgo)
          .count()
          .get();

      newUsersCount = usersSnapshot.count ?? 0;

      // 4. Calculate Profit & Loss (Assumptions)
      // Profit = 30% of Revenue
      // Loss (Expenses) = 70% of Revenue
      final profit = totalRevenue * 0.30;
      final loss = totalRevenue * 0.70;

      return {
        'totalRevenue': totalRevenue,
        'activeFlights': activeFlightsCount,
        'newUsers': newUsersCount,
        'profit': profit,
        'loss': loss,
        'loadFactor':
            85, // Placeholder/Mock for now as we don't have total seat capacity per flight easily available
      };
    } catch (e) {
      print('Error fetching dashboard stats: $e');
      return {
        'totalRevenue': 0.0,
        'activeFlights': 0,
        'newUsers': 0,
        'profit': 0.0,
        'loss': 0.0,
        'loadFactor': 0,
      };
    }
  }

  // Get User Counts by Role
  Future<Map<String, int>> getUserCounts() async {
    Map<String, int> counts = {
      'Total': 0,
      'Customer': 0,
      'Staff': 0,
      'Pilot': 0,
      'Admin': 0,
    };

    try {
      final snapshot = await _firestore.collection('users').get();
      counts['Total'] = snapshot.docs.length;

      for (var doc in snapshot.docs) {
        final roleStr = doc.data()['role'] as String? ?? 'customer';
        // Map string to enum or just key matches
        // Role string usually matches UserRole.name or toString()
        // Our UserRole enum values: customer, pilot, staff, attendant, admin

        // Normalize role string check
        String role = roleStr.toLowerCase().replaceAll('userrole.', '');

        if (role == 'customer')
          counts['Customer'] = (counts['Customer'] ?? 0) + 1;
        else if (role == 'staff' || role == 'attendant')
          counts['Staff'] = (counts['Staff'] ?? 0) + 1;
        else if (role == 'pilot')
          counts['Pilot'] = (counts['Pilot'] ?? 0) + 1;
        else if (role == 'admin')
          counts['Admin'] = (counts['Admin'] ?? 0) + 1;
      }
    } catch (e) {
      print('Error fetching user counts: $e');
    }

    return counts;
  }

  // Get All Users
  Future<List<UserModel>> getAllUsers() async {
    try {
      final snapshot = await _firestore.collection('users').get();
      return snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  // Update User Role
  Future<bool> updateUserRole(String uid, UserRole newRole) async {
    try {
      // Assuming role is stored as string in Firestore
      // Or if UserModel.toJson handles enum conversion perfectly, we can use that.
      // Checking UserModel logic... currently it likely uses string or name.

      // Let's store simply as the enum name or index if consistent.
      // Based on previous code, let's stick to simple string representation matching UserRole enum.

      // We need to match how UserModel serializes.
      // If UserModel isn't handy, let's assume 'role' field stores string 'customer', 'admin' etc.

      await _firestore.collection('users').doc(uid).update({
        'role': newRole.name,
      });
      return true;
    } catch (e) {
      print('Error updating user role: $e');
      return false;
    }
  }
}

extension UserRoleExtension on UserRole {
  String getJsonValue() {
    return this.toString().split('.').last;
  }
}
