import 'package:flutter/material.dart';
import '../models/ticket_model.dart';
import '../theme/app_theme.dart'; // Assuming this exists based on previous files

class ETicketCard extends StatelessWidget {
  final Ticket ticket;

  const ETicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Section (Flight Info)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.maryBlack, // Using app theme info I saw earlier
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.flight_takeoff,
                          color: AppTheme.maryGold,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'MaryAir',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily:
                                'GoogleFonts.outfit().fontFamily', // Guessing font usage
                          ),
                        ),
                      ],
                    ),
                    Text(
                      ticket.flightNumber,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAirportCode(
                      ticket.origin,
                      ticket.originName,
                      CrossAxisAlignment.start,
                    ),
                    const Icon(
                      Icons.compare_arrows,
                      color: Colors.white54,
                      size: 30,
                    ),
                    _buildAirportCode(
                      ticket.destination,
                      ticket.destinationName,
                      CrossAxisAlignment.end,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Middle Section (Details)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoItem(
                      'Date',
                      '${ticket.departureTime.day}/${ticket.departureTime.month}',
                    ),
                    _buildInfoItem(
                      'Time',
                      '${ticket.departureTime.hour}:${ticket.departureTime.minute.toString().padLeft(2, '0')}',
                    ),
                    _buildInfoItem('Class', ticket.cabinClass),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoItem(
                      'Passenger',
                      _truncateName(ticket.passengerName),
                    ),
                    _buildInfoItem('Seat', ticket.seatNumber),
                    _buildInfoItem('Group', ticket.boardingGroup),
                  ],
                ),
              ],
            ),
          ),

          // Perforated Line
          Row(
            children: List.generate(
              30,
              (index) => Expanded(
                child: Container(
                  height: 1,
                  color: index % 2 == 0 ? Colors.grey[300] : Colors.transparent,
                ),
              ),
            ),
          ),

          // Bottom Section (QR & Gate)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // QR Code
                Container(
                  width: 80,
                  height: 80,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Icon(Icons.qr_code_2, size: 70, color: Colors.black),
                  ),
                ),

                // Or use barcode_widget if available
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoItem('Terminal', ticket.terminal),
                          _buildInfoItem(
                            'Gate',
                            ticket.gate,
                            isHighlighted: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Boarding closes 20m before departure',
                        style: TextStyle(color: Colors.grey[500], fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAirportCode(String code, String city, CrossAxisAlignment align) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          code,
          style: const TextStyle(
            color: AppTheme.maryGold,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(city, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildInfoItem(
    String label,
    String value, {
    bool isHighlighted = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 10,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: isHighlighted ? AppTheme.maryOrangeRed : Colors.black87,
            fontSize: 16,
            fontWeight: isHighlighted ? FontWeight.w900 : FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _truncateName(String name) {
    if (name.length > 15) {
      return '${name.substring(0, 13)}..';
    }
    return name;
  }
}
