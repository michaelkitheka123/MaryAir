import 'dart:async';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart'; // Ensure collection package is used or handle appropriately
import '../models/seat_selection_models.dart';

class SeatSelectionService {
  static final SeatSelectionService _instance =
      SeatSelectionService._internal();
  factory SeatSelectionService() => _instance;
  SeatSelectionService._internal();

  // Current state
  AircraftCabin? _currentCabin;
  List<SeatPassenger> _passengers = [];
  SeatSelectionRules? _rules;
  Timer? _selectionTimer;
  double _remainingTime = 600.0; // 10 minutes in seconds

  // Observables
  final ValueNotifier<List<AircraftSeat>> selectedSeats = ValueNotifier([]);
  final ValueNotifier<double> totalSeatCharge = ValueNotifier(0.0);
  final ValueNotifier<bool> isSelectionValid = ValueNotifier(false);
  final ValueNotifier<double> remainingTime = ValueNotifier(600.0);

  // Initialize with flight data
  Future<void> initialize({
    required AircraftCabin cabin,
    required List<SeatPassenger> passengers,
    required SeatSelectionRules rules,
  }) async {
    _currentCabin = cabin;
    _passengers = passengers;
    _rules = rules;
    _remainingTime = rules.maxSeatSelectionTime * 60;

    // Clear previous selection
    selectedSeats.value = [];
    totalSeatCharge.value = 0.0;
    isSelectionValid.value = false;

    _startSelectionTimer();
    _validateSelection();

    print(
      'Seat Selection initialized for ${passengers.length} passengers on ${cabin.aircraftType}',
    );
  }

  // Start selection timer
  void _startSelectionTimer() {
    _selectionTimer?.cancel();
    _selectionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        remainingTime.value = _remainingTime;
      } else {
        timer.cancel();
        _timeoutSelection();
      }
    });
  }

  // Select a seat
  Future<SeatSelectionResult> selectSeat({
    required AircraftSeat seat,
    required SeatPassenger passenger,
    bool forceSelection = false,
  }) async {
    // Check if seat is available
    if (!seat.isAvailable && !forceSelection) {
      return SeatSelectionResult(
        success: false,
        message: 'Seat ${seat.seatNumber} is not available',
        errorCode: 'SEAT_UNAVAILABLE',
      );
    }

    // Check restrictions
    final restrictionCheck = _checkSeatRestrictions(seat, passenger);
    if (!restrictionCheck.success) {
      return restrictionCheck;
    }

    // Check if passenger already has a seat
    AircraftSeat? existingSeat;
    try {
      existingSeat = selectedSeats.value.firstWhere(
        (s) => s.passengerId == passenger.id,
      );
    } catch (e) {
      // No existing seat found
      existingSeat = null;
    }

    if (existingSeat != null) {
      // Deselect old seat
      await deselectSeat(existingSeat);
    }

    // Select new seat
    final updatedSeat = seat.copyWith(
      isSelected: true,
      isAvailable: false,
      passengerId: passenger.id,
      passengerName: '${passenger.firstName} ${passenger.lastName}',
      selectedAt: DateTime.now(),
    );

    // Update selected seats list
    final currentSelected = List<AircraftSeat>.from(selectedSeats.value);
    currentSelected.add(updatedSeat);
    selectedSeats.value = currentSelected;

    // Update total charge
    _updateTotalCharge();

    // Validate selection
    _validateSelection();

    // Log selection
    await _logSeatSelection(updatedSeat, passenger);

    return SeatSelectionResult(
      success: true,
      message: 'Seat ${seat.seatNumber} selected for ${passenger.firstName}',
      seat: updatedSeat,
      additionalCharge: seat.price,
    );
  }

  // Deselect a seat
  Future<void> deselectSeat(AircraftSeat seat) async {
    // Note: In a real app we'd need to find the seat in the original cabin to restore it correctly
    // For now we just remove it from selectedSeats

    final currentSelected = List<AircraftSeat>.from(selectedSeats.value);
    currentSelected.removeWhere((s) => s.seatNumber == seat.seatNumber);
    selectedSeats.value = currentSelected;

    _updateTotalCharge();
    _validateSelection();

    print('Seat ${seat.seatNumber} deselected');
  }

  // Check seat restrictions
  SeatSelectionResult _checkSeatRestrictions(
    AircraftSeat seat,
    SeatPassenger passenger,
  ) {
    if (_rules == null) return SeatSelectionResult(success: true);

    // Exit row restrictions
    if (seat.isExitRow && !_rules!.allowExitRowForMinors) {
      // Check if passenger meets exit row requirements (simplification)
      return SeatSelectionResult(
        success: false,
        message: 'Exit row seats have additional requirements',
        errorCode: 'EXIT_ROW_RESTRICTION',
      );
    }

    // Bulkhead with infants
    if (seat.isBulkhead && !_rules!.allowBulkheadForInfants) {
      return SeatSelectionResult(
        success: false,
        message: 'Bulkhead seats are not available for passengers with infants',
        errorCode: 'BULKHEAD_RESTRICTION',
      );
    }

    // Premium upgrade restrictions
    // Simplification: assume fareBasis first char determines class
    if (passenger.fareBasis.isNotEmpty &&
        seat.compartment.isNotEmpty &&
        seat.compartment[0] != passenger.fareBasis[0]) {
      if (!_rules!.allowPremiumUpgrade) {
        return SeatSelectionResult(
          success: false,
          message: 'Upgrade to ${seat.compartment} class not allowed',
          errorCode: 'UPGRADE_RESTRICTED',
        );
      }
    }

    // Special assistance considerations
    if (passenger.hasSpecialAssistance) {
      if (seat.seatType == SeatType.middle || seat.isExitRow) {
        return SeatSelectionResult(
          success: false,
          message: 'This seat may not be suitable for special assistance',
          errorCode: 'SPECIAL_ASSISTANCE',
        );
      }
    }

    return SeatSelectionResult(success: true);
  }

  // Auto-assign seats
  Future<List<AircraftSeat>> autoAssignSeats({
    bool preferWindow = false,
    bool preferAisle = false,
    bool groupTogether = true,
  }) async {
    final assignments = <AircraftSeat>[];

    for (final passenger in _passengers) {
      final availableSeats = getAvailableSeats();

      // Filter by preferences
      var filteredSeats = List<AircraftSeat>.from(availableSeats);

      if (preferWindow) {
        filteredSeats = filteredSeats
            .where((seat) => seat.seatType == SeatType.window)
            .toList();
      } else if (preferAisle) {
        filteredSeats = filteredSeats
            .where((seat) => seat.seatType == SeatType.aisle)
            .toList();
      }

      // Try to group passengers together
      if (groupTogether && assignments.isNotEmpty) {
        final lastSeat = assignments.last;
        final adjacentSeats = _findAdjacentSeats(lastSeat, filteredSeats);
        if (adjacentSeats.isNotEmpty) {
          filteredSeats = adjacentSeats;
        }
      }

      // Sort by preference: window/aisle > extra legroom > standard
      filteredSeats.sort((a, b) {
        if (a.isExtraLegroom != b.isExtraLegroom) {
          return b.isExtraLegroom ? 1 : -1;
        }
        if (a.seatPitch != b.seatPitch) {
          return b.seatPitch.compareTo(a.seatPitch);
        }
        return a.price.compareTo(b.price);
      });

      if (filteredSeats.isNotEmpty) {
        final seat = filteredSeats.first;
        final result = await selectSeat(seat: seat, passenger: passenger);
        if (result.success) {
          if (result.seat != null) {
            assignments.add(result.seat!);
          }
        }
      }
    }

    return assignments;
  }

  // Find adjacent seats
  List<AircraftSeat> _findAdjacentSeats(
    AircraftSeat referenceSeat,
    List<AircraftSeat> availableSeats,
  ) {
    final row = int.tryParse(
      referenceSeat.seatNumber.replaceAll(RegExp(r'[A-Z]'), ''),
    );
    if (row == null) return [];

    return availableSeats.where((seat) {
      final seatRow = int.tryParse(
        seat.seatNumber.replaceAll(RegExp(r'[A-Z]'), ''),
      );
      if (seatRow != row) return false;

      final refLetter = referenceSeat.seatNumber.replaceAll(
        RegExp(r'[0-9]'),
        '',
      );
      final seatLetter = seat.seatNumber.replaceAll(RegExp(r'[0-9]'), '');

      // Check if seats are adjacent (A-B, B-C, etc.)
      if (refLetter.isEmpty || seatLetter.isEmpty) return false;

      final refIndex = refLetter.codeUnitAt(0);
      final seatIndex = seatLetter.codeUnitAt(0);

      return (seatIndex - refIndex).abs() == 1;
    }).toList();
  }

  // Get available seats
  List<AircraftSeat> getAvailableSeats() {
    if (_currentCabin == null) return [];

    return _currentCabin!.sections
        .expand((section) => section.seats)
        .where(
          (seat) => seat.isAvailable && !seat.isOccupied && !seat.isBlocked,
        )
        .toList();
  }

  // Get seat recommendations
  List<AircraftSeat> getSeatRecommendations(SeatPassenger passenger) {
    final availableSeats = getAvailableSeats();

    // Sort by recommendation score
    final scoredSeats = availableSeats.map((seat) {
      double score = 0.0;

      // Base score on seat type
      switch (seat.seatType) {
        case SeatType.window:
          score += 10;
          break;
        case SeatType.aisle:
          score += 8;
          break;
        case SeatType.middle:
          score += 5;
          break;
        default:
          score += 7;
      }

      // Extra legroom bonus
      if (seat.isExtraLegroom) score += 15;

      // Exit row adjustment
      if (seat.isExitRow) score += 5;

      // Price adjustment (lower price is better, if not 0)
      if (seat.price > 0) {
        score -= seat.price / 10;
      }

      // Distance from lavatory/gallery (farther is better)
      if (!seat.isLavatoryAdjacent && !seat.isGalleyAdjacent) score += 5;

      return {'seat': seat, 'score': score};
    }).toList();

    scoredSeats.sort(
      (a, b) => (b['score'] as double).compareTo(a['score'] as double),
    );

    return scoredSeats.map((e) => e['seat'] as AircraftSeat).take(5).toList();
  }

  // Update total charge
  void _updateTotalCharge() {
    final total = selectedSeats.value.fold(
      0.0,
      (sum, seat) => sum + seat.price,
    );
    totalSeatCharge.value = total;
  }

  // Validate current selection
  void _validateSelection() {
    if (_passengers.isEmpty || _currentCabin == null) {
      isSelectionValid.value = false;
      return;
    }

    // Check if all passengers have seats
    final allPassengersHaveSeats = _passengers.every(
      (passenger) =>
          selectedSeats.value.any((seat) => seat.passengerId == passenger.id),
    );

    // Check for family seating rules
    final familySeatingValid = _checkFamilySeating();

    isSelectionValid.value = allPassengersHaveSeats && familySeatingValid;
  }

  // Check family seating
  bool _checkFamilySeating() {
    if (_rules != null && !_rules!.allowFamilySeating) return true;

    // Find passengers in same PNR
    final families = _groupByFamily();

    for (final family in families.values) {
      if (family.length > 1) {
        // Check if family members are seated together
        final familySeats = selectedSeats.value
            .where((seat) => family.contains(seat.passengerId))
            .toList();

        if (familySeats.length > 1) {
          // Check if seats are adjacent or nearby.
          // Simplified check: same row or adjacent rows?
          // Using row number for simplicity
          final rows = familySeats
              .map(
                (s) =>
                    int.tryParse(s.seatNumber.replaceAll(RegExp(r'[A-Z]'), '')),
              )
              .whereType<int>()
              .toSet();

          if (rows.length > 2) {
            // Family members are too far apart (more than 2 distinct rows)
            return false;
          }
        }
      }
    }

    return true;
  }

  Map<String, List<String>> _groupByFamily() {
    // Group by last name for simplicity
    // In real app, use PNR or booking reference
    final groups = <String, List<String>>{};

    for (final passenger in _passengers) {
      final key = passenger.lastName;
      if (!groups.containsKey(key)) {
        groups[key] = [];
      }
      groups[key]!.add(passenger.id);
    }

    return groups;
  }

  // Timeout handling
  void _timeoutSelection() {
    print('Seat selection timed out');
    // Release all selected seats
    selectedSeats.value = [];
    totalSeatCharge.value = 0.0;
    isSelectionValid.value = false;

    // Notify UI
    // In real app, show timeout dialog
  }

  // Log seat selection
  Future<void> _logSeatSelection(
    AircraftSeat seat,
    SeatPassenger passenger,
  ) async {
    final logEntry = {
      'timestamp': DateTime.now().toIso8601String(),
      'seat': seat.seatNumber,
      'passenger': passenger.id,
      'action': 'SELECT',
      'price': seat.price,
      'compartment': seat.compartment,
    };

    // Send to server
    // await _apiService.logSeatSelection(logEntry);

    print('Seat selection logged: $logEntry');
  }

  // Confirm seat selection
  Future<SeatConfirmationResult> confirmSelection() async {
    if (!isSelectionValid.value) {
      return SeatConfirmationResult(
        success: false,
        message: 'Invalid seat selection',
        errorCode: 'INVALID_SELECTION',
      );
    }

    try {
      // Send to server
      final confirmation = await _sendToServer();

      // Stop timer
      _selectionTimer?.cancel();

      return SeatConfirmationResult(
        success: true,
        message: 'Seats confirmed successfully',
        confirmationNumber: confirmation['confirmationNumber'],
        seats: selectedSeats.value,
        totalCharge: totalSeatCharge.value,
      );
    } catch (e) {
      return SeatConfirmationResult(
        success: false,
        message: 'Failed to confirm seats: $e',
        errorCode: 'CONFIRMATION_FAILED',
      );
    }
  }

  Future<Map<String, dynamic>> _sendToServer() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    return {
      'confirmationNumber': 'SEAT-${DateTime.now().millisecondsSinceEpoch}',
      'status': 'CONFIRMED',
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  // Reset selection
  void reset() {
    selectedSeats.value = [];
    totalSeatCharge.value = 0.0;
    isSelectionValid.value = false;
    _selectionTimer?.cancel();
    _remainingTime = 600.0;
  }

  // Dispose
  void dispose() {
    _selectionTimer?.cancel();
    selectedSeats.dispose();
    totalSeatCharge.dispose();
    isSelectionValid.dispose();
    remainingTime.dispose();
  }
}

// Result classes
class SeatSelectionResult {
  final bool success;
  final String message;
  final String? errorCode;
  final AircraftSeat? seat;
  final double? additionalCharge;

  SeatSelectionResult({
    required this.success,
    this.message = '',
    this.errorCode,
    this.seat,
    this.additionalCharge,
  });
}

class SeatConfirmationResult {
  final bool success;
  final String message;
  final String? errorCode;
  final String? confirmationNumber;
  final List<AircraftSeat>? seats;
  final double? totalCharge;

  SeatConfirmationResult({
    required this.success,
    this.message = '',
    this.errorCode,
    this.confirmationNumber,
    this.seats,
    this.totalCharge,
  });
}
