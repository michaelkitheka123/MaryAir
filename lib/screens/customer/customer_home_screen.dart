import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/wizard_card.dart';
import '../../widgets/booking_actions_card.dart';
import '../booking/booking_wizard_screen.dart';
import '../../models/booking_state.dart';
import 'package:share_plus/share_plus.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.currentUser;
    final firstName = user?.fullName.split(' ').first ?? 'Customer';

    return Scaffold(
      backgroundColor: AppTheme.maryBlack,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: Column(
              children: [
                // Main Content Overlay
                SizedBox(
                  width: MediaQuery.of(context).size.width > 600
                      ? MediaQuery.of(context).size.width * 0.9
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.maryGreen.withOpacity(0.05),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      border: Border.all(
                        color: AppTheme.maryGreen.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(AppTheme.spacingL),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // HEADER ROW
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Profile Image & Greeting
                            GestureDetector(
                              onTap: () {
                                // TODO: Pick Image
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppTheme.maryOrangeRed,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.maryOrangeRed.withOpacity(
                                        0.3,
                                      ),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: const CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.grey,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  // backgroundImage: user.profileUrl != null ? NetworkImage(user.profileUrl!) : null,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppTheme.spacingM),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hi,',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                ),
                                Text(
                                  firstName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),

                            const Spacer(),

                            // Branding (Right Aligned)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ShaderMask(
                                  shaderCallback: (bounds) =>
                                      const LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Colors.purple,
                                          AppTheme.maryOrangeRed,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ).createShader(bounds),
                                  child: Text(
                                    'MaryAir',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 1,
                                        ),
                                  ),
                                ),
                                Text(
                                  'Where quality meets affordability',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: AppTheme.maryOrangeRed,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 10,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: AppTheme.spacingM),

                        // Divider
                        const Divider(
                          color: AppTheme.maryOrangeRed,
                          thickness: 1,
                        ),

                        const SizedBox(height: AppTheme.spacingXL),

                        // Action Cards
                        WizardCard(
                          onTap: () {
                            // Start fresh booking
                            context.read<BookingState>().startNewBooking();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const BookingWizardScreen(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppTheme.maryGreen.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.flight_takeoff,
                                  color: AppTheme.maryGreen,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(width: AppTheme.spacingM),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Book a Flight',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Start a new journey',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: Colors.white70),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: AppTheme.maryGold,
                                size: 18,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: AppTheme.spacingM),

                        // Active Bookings (if any)
                        Consumer<BookingState>(
                          builder: (context, bookingState, _) {
                            if (bookingState.activeTickets.isEmpty)
                              return const SizedBox.shrink();

                            return Padding(
                              padding: const EdgeInsets.only(
                                top: AppTheme.spacingL,
                              ),
                              child: BookingActionsCard(
                                tickets: bookingState.activeTickets,
                                isDark: true,
                                onRemove: (ticket) {
                                  // Real removal from state
                                  bookingState.removeTicket(ticket);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Booking cancelled.'),
                                    ),
                                  );
                                },
                                onReschedule: (ticket) async {
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: ticket.departureTime,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(
                                      const Duration(days: 365),
                                    ),
                                  );
                                  if (date != null) {
                                    // Real reschedule in state
                                    bookingState.rescheduleTicket(ticket, date);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Rescheduled to ${date.toString().split(' ')[0]}',
                                        ),
                                      ),
                                    );
                                  }
                                },
                                onShare: (ticket) {
                                  final text =
                                      'Flight Details:\n'
                                      '${ticket.passengerName}\n'
                                      '${ticket.origin} -> ${ticket.destination}\n'
                                      '${ticket.dateFormatted} ${ticket.departureTimeFormatted}\n'
                                      'Flight: ${ticket.flightNumber}\n'
                                      'Seat: ${ticket.seatNumber}';

                                  Share.share(text);
                                },
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: AppTheme.spacingXXL),

                        // Sign Out
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            text: 'Sign Out',
                            isOutlined: true,
                            icon: Icons.logout,
                            textColor: Colors.white,
                            borderColor: Colors.white54,
                            onPressed: () async {
                              await authProvider.signOut();
                              if (context.mounted) {
                                Navigator.pushReplacementNamed(context, '/');
                              }
                            },
                            // We might need to style CustomButton to handle dark mode if it doesn't already
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
