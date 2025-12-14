import 'dart:math';
import 'package:flutter/material.dart';
// ... rest of imports

// ... existing code ...

import 'package:qr_flutter/qr_flutter.dart';
import '../models/ticket_model.dart';
import '../utils/country_utils.dart';

class HorizontalETicketCard extends StatelessWidget {
  final Ticket ticket;
  final double width;
  final double height;
  final bool interactive;

  const HorizontalETicketCard({
    super.key,
    required this.ticket,
    this.width = 1000,
    this.height = 300,
    this.interactive = true,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = ticket.themeColor;

    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Color.lerp(
          Colors.white,
          themeColor,
          0.25,
        ), // Increased tint for visibility
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: themeColor.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: themeColor.withOpacity(0.3), width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Column 1: User's Uploaded Image
          _buildUserImageColumn(),

          // Column 3: Personal & Travel Details
          _buildDetailsColumn(),

          // Column 4: Destination & QR Code (Modified per user request)
          _buildLogoAndQrColumn(themeColor),
        ],
      ),
    );
  }

  // Column 1: User's Uploaded Image (Full height)
  Widget _buildUserImageColumn() {
    ImageProvider? imageProvider;
    if (ticket.profileImageBytes != null) {
      imageProvider = MemoryImage(ticket.profileImageBytes);
    } else if (ticket.profileImageUrl != null) {
      imageProvider = NetworkImage(ticket.profileImageUrl!);
    }

    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: ticket.themeColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          bottomLeft: Radius.circular(18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: imageProvider != null
          ? ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
              child: Image(
                image: imageProvider,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholderImage(),
              ),
            )
          : _buildPlaceholderImage(),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ticket.themeColor.withOpacity(0.1),
            ticket.themeColor.withOpacity(0.05),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          bottomLeft: Radius.circular(18),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 60,
              color: ticket.themeColor.withOpacity(0.3),
            ),
            const SizedBox(height: 8),
            Text(
              ticket.passengerName.split(' ').first,
              style: TextStyle(
                color: ticket.themeColor.withOpacity(0.6),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Column 2: Nationality Flag Band (Curved and Twisted)
  // Column 2: Nationality Flag Band (Simplified Vertical Strip)

  // Column 3: Personal & Travel Details
  Widget _buildDetailsColumn() {
    final departureGreeting = CountryUtils.getDepartureGreeting(
      ticket.originLanguage,
      ticket.originCountry,
    );

    final arrivalGreeting = CountryUtils.getArrivalGreeting(
      ticket.destinationLanguage,
      ticket.destinationCountry,
    );

    final firstName = ticket.passengerName.split(' ').first;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Departure Details Column
            Expanded(
              child: _buildTravelDetailsColumn(
                isDeparture: true,
                greeting: departureGreeting,
                countryCode: ticket.origin,
                countryName: ticket.originName,
                passengerName: firstName,
              ),
            ),

            // Center divider with flight info
            Container(
              width: 1,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    ticket.themeColor.withOpacity(0.3),
                    ticket.themeColor.withOpacity(0.6),
                    ticket.themeColor.withOpacity(0.3),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            // Arrival Details Column
            Expanded(
              child: _buildTravelDetailsColumn(
                isDeparture: false,
                greeting: arrivalGreeting,
                countryCode: ticket.destination,
                countryName: ticket.destinationName,
                passengerName: firstName,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTravelDetailsColumn({
    required bool isDeparture,
    required String greeting,
    required String countryCode,
    required String countryName,
    required String passengerName,
  }) {
    final themeColor = ticket.themeColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Section header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: themeColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: themeColor.withOpacity(0.3), width: 1),
          ),
          child: Text(
            isDeparture ? 'DEPARTURE' : 'ARRIVAL',
            style: TextStyle(
              color: themeColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),

        // Updated Greeting message (First Name Only)
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$greeting $passengerName', // Name always at the end
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                countryName,
                style: TextStyle(
                  fontSize: 11,
                  color: themeColor.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        // Airport code and name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              countryCode,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: themeColor,
                height: 1,
              ),
            ),
            Text(
              countryName,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),

        // Time and date with detailed Boarding info
        if (isDeparture) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    ticket.departureTimeFormatted,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'hrs',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const Text(
                'Departure Time',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket.dateFormatted,
                      style: const TextStyle(
                        fontSize: 14, // Prominent date
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'BOARDING: ${_formatTime(ticket.boardingTime)}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const Text(
                      'Gate Closes 20m before dep',
                      style: TextStyle(fontSize: 7, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ] else ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ticket.arrivalTimeFormatted,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Text(
                'Arrival Time',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ],

        // Additional info (Seat, Gate, Terminal, Baggage)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildDetailItem(
                  Icons.airline_seat_recline_normal,
                  'SEAT',
                  ticket.seatNumber,
                ),
                const SizedBox(width: 12),
                _buildDetailItem(
                  Icons.door_sliding_outlined,
                  'GATE',
                  ticket.gate,
                ),
                const SizedBox(width: 12),
                _buildDetailItem(Icons.flight_takeoff, 'TERM', ticket.terminal),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildDetailItem(
                  Icons.local_mall_outlined,
                  'BAGS',
                  ticket.baggageAllowance,
                ),
                const SizedBox(width: 12),
                _buildDetailItem(
                  Icons.confirmation_number_outlined,
                  'TKT',
                  '...${ticket.ticketNumber.substring(ticket.ticketNumber.length - 4)}',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 10, color: Colors.grey),
            const SizedBox(width: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 8,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  // Column 4: Destination & QR Code (Modified)
  Widget _buildLogoAndQrColumn(Color themeColor) {
    return Container(
      width: 140, // Slightly narrower to prevent overall overflow
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [themeColor.withOpacity(0.05), themeColor.withOpacity(0.02)],
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
        border: Border(
          left: BorderSide(color: themeColor.withOpacity(0.1), width: 1),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Airline Logo / Destination Header
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // MaryAir Logo (Top)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.flight, size: 16, color: themeColor),
                    const SizedBox(width: 4),
                    Text(
                      'MaryAir',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: themeColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                // Destination Icon
                Icon(Icons.public, size: 32, color: themeColor),
                const SizedBox(height: 8),
                Text(
                  ticket.destinationCountry.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 1,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                const Text(
                  'DESTINATION',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.grey,
                    letterSpacing: 2,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),

          // QR Code (Compact)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: themeColor.withOpacity(0.3), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                QrImageView(
                  data: ticket.qrData,
                  version: QrVersions.auto,
                  size: 70, // Reduced size to prevent overflow
                  eyeStyle: QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: themeColor,
                  ),
                  dataModuleStyle: const QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'SCAN TO BOARD',
                  style: TextStyle(
                    fontSize: 8,
                    color: themeColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// Helper function and CustomPainter class
List<double> _calculateSweepStops(int colorCount) {
  final stops = <double>[];
  final step = 1.0 / colorCount;
  for (int i = 0; i <= colorCount; i++) {
    stops.add(i * step);
  }
  return stops;
}

class _FlagRibbonPainter extends CustomPainter {
  final List<Color> colors;
  final bool isTwisted;

  _FlagRibbonPainter({required this.colors, required this.isTwisted});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final path = Path();

    // Draw a semi-circular arc ribbon
    final rect = Rect.fromLTWH(10, 0, size.width - 20, size.height);
    const startAngle = -pi;
    const sweepAngle = pi;

    // Create the arc
    path.arcTo(rect, startAngle, sweepAngle, false);

    // Add thickness to create ribbon effect
    final ribbonThickness = 20.0;
    final ribbonPath = Path();
    ribbonPath.addArc(
      rect.deflate(ribbonThickness / 2),
      startAngle,
      sweepAngle,
    );

    // Calculate color bands
    final bandHeight = size.height / colors.length;

    for (int i = 0; i < colors.length; i++) {
      final bandRect = Rect.fromLTWH(
        10,
        i * bandHeight,
        size.width - 20,
        bandHeight,
      );

      paint.color = colors[i];

      // Create curved band
      final bandPath = Path();
      bandPath.addArc(bandRect, startAngle, sweepAngle);

      canvas.drawPath(bandPath, paint);

      // Add subtle separation between bands
      if (i < colors.length - 1) {
        paint.color = Colors.white.withOpacity(0.3);
        canvas.drawLine(
          Offset(10, (i + 1) * bandHeight),
          Offset(size.width - 10, (i + 1) * bandHeight),
          paint..strokeWidth = 0.5,
        );
      }
    }

    // Add shadow to ribbon
    paint
      ..color = Colors.black.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, paint);

    // Add highlight to top edge of ribbon
    paint
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
