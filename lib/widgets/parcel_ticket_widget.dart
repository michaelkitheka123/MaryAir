import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../theme/app_theme.dart';
import '../../models/parcel_model.dart';

class ParcelTicketWidget extends StatelessWidget {
  final Parcel parcel;

  const ParcelTicketWidget({super.key, required this.parcel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header (Logo & Title)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingM,
              vertical: 12,
            ),
            decoration: const BoxDecoration(
              color: AppTheme.maryBlack,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                // Logo Placeholder
                const Icon(
                  Icons.flight_takeoff,
                  color: AppTheme.maryOrangeRed,
                  size: 24,
                ),
                const SizedBox(width: 8),
                const Text(
                  'MaryAir Cargo',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.maryOrangeRed,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    parcel.id,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Main Content
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Col 1: Image & Code (Flex 3)
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: parcel.photoBytes != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.memory(
                                  parcel.photoBytes!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(
                                Icons.inventory_2,
                                size: 40,
                                color: Colors.grey,
                              ),
                      ),
                      const SizedBox(height: 12),
                      // QR Code Mock
                      QrImageView(
                        data: parcel.id,
                        version: QrVersions.auto,
                        size: 80.0,
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Scan to Track',
                        style: TextStyle(color: Colors.grey[500], fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: AppTheme.spacingM),

                // Col 2: Data (Flex 7)
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Route Highlighting
                      Row(
                        children: [
                          Expanded(
                            child: _buildBigCode(parcel.origin, 'Origin'),
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.grey,
                            size: 16,
                          ),
                          Expanded(
                            child: _buildBigCode(
                              parcel.destination,
                              'Destination',
                            ),
                          ),
                        ],
                      ),
                      const Divider(),

                      // Dates
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDetail(
                            'Departure',
                            _formatDate(parcel.departureDate),
                          ),
                          _buildDetail(
                            'Est. Arrival',
                            _formatDate(
                              parcel.departureDate.add(
                                const Duration(hours: 8),
                              ),
                            ),
                          ), // Mock duration
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Commodity Info
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDetail('Commodity', parcel.commodityType),
                          _buildDetail('Weight', '${parcel.weightKg} kg'),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Parties
                      _buildRow(
                        'Sender',
                        '${parcel.senderName}\n${parcel.senderContact}',
                      ),
                      const SizedBox(height: 8),
                      _buildRow(
                        'Receiver',
                        '${parcel.receiverName}\n${parcel.receiverContact}',
                      ),

                      const Divider(height: 24),

                      // Cost
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Paid',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\$${parcel.cost.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: AppTheme.maryOrangeRed,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Branding strip
          Container(
            width: double.infinity,
            height: 4,
            decoration: const BoxDecoration(
              color: AppTheme.maryOrangeRed,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildBigCode(String code, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          code,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 10)),
      ],
    );
  }

  Widget _buildDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 10)),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: TextStyle(color: Colors.grey[500], fontSize: 11),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
