import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../models/seat_selection_models.dart';
import '../services/seat_selection_service.dart';

class AircraftSeatMap extends StatefulWidget {
  final AircraftCabin cabin;
  final List<SeatPassenger> passengers;
  final Function(List<AircraftSeat>) onSelectionChanged;
  final bool interactive;

  const AircraftSeatMap({
    super.key,
    required this.cabin,
    required this.passengers,
    required this.onSelectionChanged,
    this.interactive = true,
  });

  @override
  _AircraftSeatMapState createState() => _AircraftSeatMapState();
}

class _AircraftSeatMapState extends State<AircraftSeatMap> {
  final SeatSelectionService _service = SeatSelectionService();
  final Map<String, GlobalKey> _seatKeys = {};

  @override
  void initState() {
    super.initState();
    _initializeService();
  }

  void _initializeService() {
    _service.selectedSeats.addListener(_onSelectionChanged);
  }

  void _onSelectionChanged() {
    widget.onSelectionChanged(_service.selectedSeats.value);
    setState(() {}); // Rebuild to update seat states UI
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Aircraft Overview
        _buildAircraftOverview(),
        const SizedBox(height: 20),

        // Seat Map with sections
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // First Class Section
                if (widget.cabin.sections.any((s) => s.name == 'First'))
                  _buildCabinSection('First'),

                // Business Class Section
                if (widget.cabin.sections.any((s) => s.name == 'Business'))
                  _buildCabinSection('Business'),

                // Premium Economy Section
                if (widget.cabin.sections.any((s) => s.name == 'Premium'))
                  _buildCabinSection('Premium'),

                // Economy Section
                if (widget.cabin.sections.any((s) => s.name == 'Economy'))
                  _buildCabinSection('Economy'),
              ],
            ),
          ),
        ),

        // Legend
        _buildLegend(),
      ],
    );
  }

  Widget _buildAircraftOverview() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.cabin.aircraftType} • ${widget.cabin.registration}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                '${widget.cabin.airlineCode} • ${widget.cabin.configurationId}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${widget.cabin.availableSeats} seats available',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${_service.selectedSeats.value.length}/${widget.passengers.length} selected',
                style: const TextStyle(color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCabinSection(String sectionName) {
    final section = widget.cabin.sections.firstWhere(
      (s) => s.name == sectionName,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: section.sectionColor.withOpacity(0.1),
              border: Border(
                left: BorderSide(color: section.sectionColor, width: 4),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  section.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: section.sectionColor,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Rows ${section.startRow}-${section.endRow}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Seat Arrangement Diagram
          _buildSeatArrangement(section),
          const SizedBox(height: 12),

          // Seat Rows
          ..._buildSeatRows(section),
        ],
      ),
    );
  }

  Widget _buildSeatArrangement(CabinSection section) {
    final arrangement = section.seatArrangement.split('-');

    return Center(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Left side seats
            Row(
              children: arrangement.sublist(0, arrangement.length ~/ 2).map((
                count,
              ) {
                return Row(
                  children: List.generate(
                    int.parse(count),
                    (_) => const _SeatIcon(size: 16),
                  ),
                );
              }).toList(),
            ),

            // Aisle
            Container(
              width: 40,
              height: 24,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Center(
                child: Text('AISLE', style: TextStyle(fontSize: 10)),
              ),
            ),

            // Right side seats
            Row(
              children: arrangement.sublist(arrangement.length ~/ 2).map((
                count,
              ) {
                return Row(
                  children: List.generate(
                    int.parse(count),
                    (_) => const _SeatIcon(size: 16),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSeatRows(CabinSection section) {
    final rows = <Widget>[];

    for (int row = section.startRow; row <= section.endRow; row++) {
      final seatsInRow =
          section.seats
              .where((seat) => seat.seatNumber.startsWith('$row'))
              .toList()
            ..sort((a, b) => a.seatNumber.compareTo(b.seatNumber));

      rows.add(
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              // Row Number
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  '$row',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              // Seats
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: seatsInRow.map((seat) {
                    _seatKeys[seat.seatNumber] = GlobalKey();

                    // Check if seat is selected in service to ensure UI reflects state
                    final isSelected = _service.selectedSeats.value.any(
                      (s) => s.seatNumber == seat.seatNumber,
                    );
                    final displaySeat = isSelected
                        ? seat.copyWith(isSelected: true)
                        : seat;

                    return _SeatWidget(
                      key: _seatKeys[seat.seatNumber],
                      seat: displaySeat,
                      onTap: widget.interactive
                          ? () => _onSeatTapped(displaySeat)
                          : null,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return rows;
  }

  void _onSeatTapped(AircraftSeat seat) {
    if (!seat.isAvailable && !seat.isSelected) {
      // Allow tapping if occupied to see info, but handle selection logic
      if (seat.isOccupied || seat.isBlocked) {
        _showSeatInfo(seat);
        return;
      }
    }

    if (seat.isSelected) {
      // Deselect
      _service.deselectSeat(seat);
      return;
    }

    // Find first passenger without a seat or the currently selected passenger
    // For this demo, we auto-assign to the first passenger who doesn't have a seat
    // In a real app, you might select the passenger first from a top bar

    final assignedPassengerIds = _service.selectedSeats.value
        .map((s) => s.passengerId)
        .toList();
    final passengerToAssign = widget.passengers.firstWhereOrNull(
      (p) => !assignedPassengerIds.contains(p.id),
    );

    if (passengerToAssign == null) {
      // All passengers have seats. Maybe suggest swapping?
      // For now, show message.
      _showErrorDialog(
        'All passengers have seats selected. Deselect a seat to change.',
      );
      return;
    }

    _service.selectSeat(seat: seat, passenger: passengerToAssign).then((
      result,
    ) {
      if (!result.success) {
        _showErrorDialog(result.message);
      }
    });
  }

  void _showSeatInfo(AircraftSeat seat) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _SeatInfoSheet(seat: seat),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cannot Select Seat'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        children: const [
          _LegendItem(
            color: Colors.green,
            label: 'Available',
            icon: Icons.event_seat,
          ),
          _LegendItem(
            color: Colors.blue,
            label: 'Selected',
            icon: Icons.event_seat,
          ),
          _LegendItem(
            color: Colors.red,
            label: 'Occupied',
            icon: Icons.event_seat,
          ),
          _LegendItem(color: Colors.grey, label: 'Blocked', icon: Icons.block),
          _LegendItem(color: Colors.orange, label: 'Premium', icon: Icons.star),
          _LegendItem(
            color: Colors.purple,
            label: 'Exit Row',
            icon: Icons.exit_to_app,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _service.selectedSeats.removeListener(_onSelectionChanged);
    super.dispose();
  }
}

class _SeatWidget extends StatelessWidget {
  final AircraftSeat seat;
  final VoidCallback? onTap;

  const _SeatWidget({super.key, required this.seat, this.onTap});

  @override
  Widget build(BuildContext context) {
    Color seatColor;
    IconData? seatIcon;
    Color iconColor = Colors.white;

    // Determine seat color and icon based on status
    if (seat.isBlocked) {
      seatColor = Colors.grey[400]!;
      seatIcon = Icons.block;
    } else if (seat.isOccupied) {
      seatColor = Colors.red;
      seatIcon = Icons.person;
    } else if (seat.isSelected) {
      seatColor = Colors.blue;
      seatIcon = Icons.check;
    } else if (seat.isPremiumSeat) {
      seatColor = Colors.orange;
      seatIcon = Icons.star_border;
      iconColor = Colors.white;
    } else if (seat.isExitRow) {
      seatColor = Colors.purple;
      seatIcon = Icons.exit_to_app;
    } else {
      seatColor = Colors.green;
      seatIcon = Icons.event_seat;
    }

    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: _buildTooltipText(),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: seatColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: seat.isSelected ? Colors.blue : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              if (seat.isSelected)
                BoxShadow(
                  color: Colors.blue.withOpacity(0.5),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(seatIcon, size: 16, color: iconColor),
              Text(
                seat.seatNumber.replaceAll(RegExp(r'[0-9]'), ''),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _buildTooltipText() {
    final details = <String>[];

    details.add('Seat ${seat.seatNumber}');
    details.add('${seat.seatType.displayName}');
    details.add('${seat.compartment} Class');

    if (seat.isExtraLegroom) details.add('Extra Legroom');
    if (seat.isExitRow) details.add('Exit Row');
    if (seat.isBulkhead) details.add('Bulkhead');
    if (seat.hasPowerOutlet) details.add('Power Outlet');
    if (seat.hasInSeatScreen) details.add('Personal Screen');

    details.add('${seat.seatPitch}" pitch');
    details.add('${seat.seatWidth}" width');

    if (seat.price > 0) details.add('\$${seat.price.toStringAsFixed(2)}');

    return details.join('\n');
  }
}

class _SeatIcon extends StatelessWidget {
  final double size;

  const _SeatIcon({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(icon, size: 12, color: Colors.white),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class _SeatInfoSheet extends StatelessWidget {
  final AircraftSeat seat;

  const _SeatInfoSheet({required this.seat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Seat ${seat.seatNumber}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(seat),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getStatusText(seat),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Seat Details Grid
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3,
            children: [
              _DetailItem(
                icon: Icons.airline_seat_recline_normal,
                label: 'Type',
                value: seat.seatType.displayName,
              ),
              _DetailItem(
                icon: Icons.business,
                label: 'Class',
                value: seat.compartment,
              ),
              _DetailItem(
                icon: Icons.straighten,
                label: 'Pitch',
                value: '${seat.seatPitch}"',
              ),
              _DetailItem(
                icon: Icons.width_normal,
                label: 'Width',
                value: '${seat.seatWidth}"',
              ),
              _DetailItem(
                icon: Icons.attach_money,
                label: 'Price',
                value: '\$${seat.price.toStringAsFixed(2)}',
              ),
              _DetailItem(
                icon: Icons.recommend,
                label: 'Features',
                value: seat.amenities.join(', '),
              ),
            ],
          ),

          const SizedBox(height: 20),

          if (seat.hasRestrictions) ...[
            const Text(
              'Restrictions:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                if (!seat.isInfantAllowed)
                  const Chip(
                    label: Text('No Infants'),
                    backgroundColor: Colors.red,
                  ),
                if (seat.isCrewRest)
                  const Chip(
                    label: Text('Crew Rest'),
                    backgroundColor: Colors.orange,
                  ),
                if (seat.isBlocked)
                  const Chip(
                    label: Text('Blocked'),
                    backgroundColor: Colors.grey,
                  ),
              ],
            ),
          ],

          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(AircraftSeat seat) {
    if (seat.isBlocked) return Colors.grey;
    if (seat.isOccupied) return Colors.red;
    if (seat.isSelected) return Colors.blue;
    return Colors.green;
  }

  String _getStatusText(AircraftSeat seat) {
    if (seat.isBlocked) return 'BLOCKED';
    if (seat.isOccupied) return 'OCCUPIED';
    if (seat.isSelected) return 'SELECTED';
    return 'AVAILABLE';
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}
