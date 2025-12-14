import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_button.dart';
import 'user_management_screen.dart';
import '../../services/admin_service.dart';

class ManagementHomeScreen extends StatefulWidget {
  const ManagementHomeScreen({super.key});

  @override
  State<ManagementHomeScreen> createState() => _ManagementHomeScreenState();
}

class _ManagementHomeScreenState extends State<ManagementHomeScreen> {
  final AdminService _adminService = AdminService();
  Map<String, dynamic> _stats = {
    'totalRevenue': 0.0,
    'activeFlights': 0,
    'newUsers': 0,
    'profit': 0.0,
    'loss': 0.0,
    'loadFactor': 0,
  };
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final stats = await _adminService.getDashboardStats();
    if (mounted) {
      setState(() {
        _stats = stats;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.maryBlack, // Admin theme
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              setState(() => _isLoading = true);
              _fetchData();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // Sign out logic
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: AppTheme.spacingM,
                    mainAxisSpacing: AppTheme.spacingM,
                    childAspectRatio: 1.5,
                    children: [
                      _buildStatCard(
                        context,
                        'Total Revenue',
                        'KES ${(_stats['totalRevenue'] as double).toStringAsFixed(0)}', // KES
                        Icons.attach_money,
                        Colors.green,
                      ),
                      _buildStatCard(
                        context,
                        'Profit (Est. 30%)',
                        'KES ${(_stats['profit'] as double).toStringAsFixed(0)}',
                        Icons.trending_up,
                        AppTheme.maryGold,
                      ),
                      _buildStatCard(
                        context,
                        'Loss/Expenses (Est. 70%)',
                        'KES ${(_stats['loss'] as double).toStringAsFixed(0)}',
                        Icons.trending_down,
                        Colors.redAccent,
                      ),
                      _buildStatCard(
                        context,
                        'Active Flights',
                        '${_stats['activeFlights']}',
                        Icons.flight,
                        AppTheme.primaryBlue,
                      ),
                      _buildStatCard(
                        context,
                        'Load Factor',
                        '${_stats['loadFactor']}%',
                        Icons.pie_chart,
                        Colors.orange,
                      ),
                      _buildStatCard(
                        context,
                        'New Users (30d)',
                        '+${_stats['newUsers']}',
                        Icons.group_add,
                        Colors.purple,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacingL),

                  const Text(
                    'Management Tools',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingM),

                  // Management List
                  _buildManagementTile(
                    context,
                    'User Management',
                    'Manage roles and permissions',
                    Icons.people_alt,
                    Colors.blueAccent,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserManagementScreen(),
                        ),
                      );
                    },
                  ),
                  _buildManagementTile(
                    context,
                    'Flight Management',
                    'Add, edit, or cancel flights',
                    Icons.flight_takeoff,
                    Colors.orangeAccent,
                    () {
                      // Navigate to Flight Management
                    },
                  ),
                  _buildManagementTile(
                    context,
                    'Discounts & Promos',
                    'Create discount codes',
                    Icons.local_offer,
                    Colors.pinkAccent,
                    () {
                      // Navigate to Discounts
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManagementTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white54),
        onTap: onTap,
      ),
    );
  }
}
