import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/user_model.dart';
import '../../models/user_role.dart';
import '../../services/admin_service.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final AdminService _adminService = AdminService();
  List<UserModel> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final users = await _adminService.getAllUsers();
    if (mounted) {
      setState(() {
        _users = users;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.maryBlack,
      appBar: AppBar(
        title: const Text('User Management'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              setState(() => _isLoading = true);
              _fetchUsers();
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _users.isEmpty
          ? const Center(
              child: Text(
                'No users found',
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return Card(
                  color: Colors.white.withOpacity(0.05),
                  margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getRoleColor(
                        user.role,
                      ).withOpacity(0.2),
                      child: Icon(
                        _getRoleIcon(user.role),
                        color: _getRoleColor(user.role),
                      ),
                    ),
                    title: Text(
                      user.fullName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${user.email}\n${user.role.displayName}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: AppTheme.primaryBlue),
                      onPressed: () => _showEditRoleDialog(user),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Color _getRoleColor(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return Colors.redAccent;
      case UserRole.pilot:
        return AppTheme.maryGold;
      case UserRole.staff:
        return Colors.orangeAccent;
      case UserRole.attendant:
        return Colors.pinkAccent;
      case UserRole.customer:
        return Colors.blueAccent;
    }
  }

  IconData _getRoleIcon(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return Icons.security;
      case UserRole.pilot:
        return Icons.flight;
      case UserRole.staff:
        return Icons.work;
      case UserRole.attendant:
        return Icons.airline_seat_recline_normal;
      case UserRole.customer:
        return Icons.person;
    }
  }

  void _showEditRoleDialog(UserModel user) {
    UserRole selectedRole = user.role;
    bool isUpdating = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: Text(
            'Edit Role: ${user.fullName}',
            style: const TextStyle(color: Colors.white),
          ),
          content: isUpdating
              ? const SizedBox(
                  height: 100,
                  child: Center(child: CircularProgressIndicator()),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: UserRole.values.map((role) {
                    return RadioListTile<UserRole>(
                      title: Text(
                        role.displayName,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      value: role,
                      groupValue: selectedRole,
                      activeColor: AppTheme.primaryBlue,
                      onChanged: (value) {
                        setState(() => selectedRole = value!);
                      },
                    );
                  }).toList(),
                ),
          actions: isUpdating
              ? []
              : [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() => isUpdating = true);

                      final success = await _adminService.updateUserRole(
                        user.uid,
                        selectedRole,
                      );

                      if (mounted) {
                        Navigator.pop(context);
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Role updated to ${selectedRole.displayName}',
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                          _fetchUsers(); // Refresh list
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to update role'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                    ),
                    child: const Text('Save'),
                  ),
                ],
        ),
      ),
    );
  }
}
