import 'package:flutter/material.dart';
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
          // Header
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            decoration: const BoxDecoration(
              color: AppTheme.maryOrangeRed, // Cargo color
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'CARGO RECEIPT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  parcel.id,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Photo Column
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
                      const SizedBox(height: 8),
                      Text(
                        'Goods Photo',
                        style: TextStyle(color: Colors.grey[600], fontSize: 10),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppTheme.spacingM),

                // Data Column
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Route
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildCodeColumn(parcel.origin, 'Origin'),
                          const Icon(
                            Icons.flight_takeoff,
                            color: AppTheme.maryOrangeRed,
                            size: 20,
                          ),
                          _buildCodeColumn(parcel.destination, 'Destination'),
                        ],
                      ),
                      const Divider(height: 24),

                      // Sender / Receiver
                      _buildRow('Sender', parcel.senderName),
                      const SizedBox(height: 4),
                      _buildRow('Receiver', parcel.receiverName),
                      const Divider(height: 24),

                      // Flight & Date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildField('Flight', parcel.flightNumber),
                          _buildField(
                            'Date',
                            parcel.departureDate.toString().split(' ')[0],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Parcel Details
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildField('Weight', '${parcel.weightKg} kg'),
                          _buildField('Dims', parcel.dimensions),
                        ],
                      ),

                      const Divider(height: 24),

                      // Cost
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Cost',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\$${parcel.cost.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: AppTheme.maryOrangeRed,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
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

          // Footer
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingS),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Text(
                'MaryAir Cargo Service',
                style: TextStyle(color: Colors.grey[500], fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeColumn(String code, String label) {
    return Column(
      children: [
        Text(
          code,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 10)),
      ],
    );
  }

  Widget _buildField(String label, String value) {
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
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
