import 'package:flutter/material.dart';
import '../models/ticket_model.dart';
import '../theme/app_theme.dart';
import 'custom_button.dart';

class BookingActionsCard extends StatelessWidget {
  final List<Ticket> tickets;
  final Function(Ticket) onRemove;
  final Function(Ticket) onReschedule;
  final Function(Ticket) onShare;
  final bool isDark;

  const BookingActionsCard({
    super.key,
    required this.tickets,
    required this.onRemove,
    required this.onReschedule,
    required this.onShare,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    if (tickets.isEmpty) return const SizedBox.shrink();

    // Use the theme color of the first ticket or default
    final themeColor = tickets.first.themeColor;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white70 : Colors.grey[600];
    final cardBg = isDark ? AppTheme.maryBlack : Colors.white;
    final borderColor = isDark
        ? AppTheme.maryOrangeRed.withOpacity(0.5)
        : Colors.grey.withOpacity(0.2);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tickets.length,
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: isDark ? Colors.white12 : Colors.grey[200],
            ),
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              return _buildBookingItem(
                context,
                ticket,
                textColor,
                subTextColor,
                themeColor,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBookingItem(
    BuildContext context,
    Ticket ticket,
    Color textColor,
    Color? subTextColor,
    Color themeColor,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Route + Name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      ticket.origin,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.flight_takeoff,
                        size: 16,
                        color: isDark ? AppTheme.maryOrangeRed : themeColor,
                      ),
                    ),
                    Text(
                      ticket.destination,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                ticket.passengerName.split(' ').first,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: subTextColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Row 2: Date • Time
          Text(
            '${ticket.dateFormatted} • ${ticket.departureTimeFormatted}',
            style: TextStyle(fontSize: 14, color: subTextColor),
          ),

          const SizedBox(height: 20),

          // Row 3: Actions (Minimalist)
          Row(
            children: [
              _buildActionButton(
                icon: Icons.calendar_today_outlined,
                label: 'Reschedule',
                color: isDark ? Colors.white : AppTheme.primaryBlue,
                onTap: () => onReschedule(ticket),
              ),
              const SizedBox(width: 16),
              _buildActionButton(
                icon: Icons.share_outlined,
                label: 'Share',
                color: isDark ? Colors.white : Colors.black87,
                onTap: () => onShare(ticket),
              ),
              const Spacer(),
              _buildActionButton(
                icon: Icons.delete_outline,
                label: 'Cancel',
                color: AppTheme.maryOrangeRed,
                onTap: () => onRemove(ticket),
                isDestructive: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
