import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../booking/booking_wizard_screen.dart';
import 'parcel_wizard_screen.dart';

class StaffOperationsScreen extends StatelessWidget {
  const StaffOperationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.maryBlack,
      appBar: AppBar(
        title: const Text('Staff Operations'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          children: [
            _buildActionCard(
              context,
              'Book for Client',
              'Process flight bookings for walk-in customers',
              Icons.book_online,
              AppTheme.maryGreen,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookingWizardScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: AppTheme.spacingM),
            _buildActionCard(
              context,
              'Send Parcel',
              'Process cargo and parcel shipments',
              Icons.local_shipping,
              AppTheme.maryOrangeRed,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ParcelWizardScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.5)),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(subtitle, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color, size: 20),
          ],
        ),
      ),
    );
  }
}
