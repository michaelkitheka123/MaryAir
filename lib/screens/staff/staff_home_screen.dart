import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/user_role.dart';
import 'management_home_screen.dart';
import 'staff_operations_screen.dart';

class StaffHomeScreen extends StatelessWidget {
  const StaffHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("StaffHomeScreen bulding...");
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.currentUser;

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    print("User Role: ${user.role}");

    if (user.role == UserRole.admin) {
      return const ManagementHomeScreen();
    } else {
      return const StaffOperationsScreen();
    }
  }
}
