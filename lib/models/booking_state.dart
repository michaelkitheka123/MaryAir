import 'package:flutter/foundation.dart';
import 'ticket_model.dart';

enum TripType { roundTrip, oneWay }

enum FlightClass { economy, business, first }

enum SeatClass { economy, business, first }

class Seat {
  final String id; // e.g., "12A"
  final int row;
  final String column; // A, B, C, D, E, F
  final SeatClass seatClass;
  bool isOccupied;
  bool isSelected;
  final bool isAisle; // For spacing in UI
  final bool isExit; // Exit row

  Seat({
    required this.id,
    required this.row,
    required this.column,
    required this.seatClass,
    this.isOccupied = false,
    this.isSelected = false,
    this.isAisle = false,
    this.isExit = false,
  });

  Seat copyWith({bool? isOccupied, bool? isSelected}) {
    return Seat(
      id: id,
      row: row,
      column: column,
      seatClass: seatClass,
      isOccupied: isOccupied ?? this.isOccupied,
      isSelected: isSelected ?? this.isSelected,
      isAisle: isAisle,
      isExit: isExit,
    );
  }
}

class SeatMap {
  List<Seat> seats;
  final int totalRows;
  final Map<SeatClass, List<String>> columnsByClass;

  SeatMap({
    required this.seats,
    required this.totalRows,
    required this.columnsByClass,
  });

  Seat? getSeatById(String seatId) {
    try {
      return seats.firstWhere((seat) => seat.id == seatId);
    } catch (e) {
      return null;
    }
  }

  List<Seat> getAvailableSeats() {
    return seats.where((seat) => !seat.isOccupied && !seat.isAisle).toList();
  }

  List<Seat> getSeatsByRow(int row) {
    return seats.where((seat) => seat.row == row).toList();
  }

  void selectSeat(String seatId) {
    final seat = getSeatById(seatId);
    if (seat != null && !seat.isOccupied) {
      final index = seats.indexOf(seat);
      seats[index] = seat.copyWith(isSelected: true);
    }
  }

  void deselectSeat(String seatId) {
    final seat = getSeatById(seatId);
    if (seat != null) {
      final index = seats.indexOf(seat);
      seats[index] = seat.copyWith(isSelected: false);
    }
  }

  void occupySeat(String seatId) {
    final seat = getSeatById(seatId);
    if (seat != null) {
      final index = seats.indexOf(seat);
      seats[index] = seat.copyWith(isOccupied: true, isSelected: false);
    }
  }

  void releaseSeat(String seatId) {
    final seat = getSeatById(seatId);
    if (seat != null) {
      final index = seats.indexOf(seat);
      seats[index] = seat.copyWith(isOccupied: false, isSelected: false);
    }
  }
}

class Passenger {
  String? fullName;
  String? passportNumber;
  String? passportPhotoPath; // Path reference
  Uint8List? passportPhotoBytes; // For cross-platform display (Web/Mobile)
  String? nationality;
  DateTime? dateOfBirth;
  String? gender; // 'Male', 'Female'
  String? selectedSeat; // e.g., "12A"
  SeatClass? seatClass;

  Passenger({
    this.fullName,
    this.passportNumber,
    this.passportPhotoPath,
    this.nationality,
    this.dateOfBirth,
    this.gender,
    this.selectedSeat,
    this.seatClass,
  });
}

class BookingState extends ChangeNotifier {
  // Phase 1: Search
  TripType tripType = TripType.roundTrip;
  String? origin;
  String? destination;
  DateTime? departureDate;
  DateTime? returnDate;
  FlightClass flightClass = FlightClass.economy;

  // Passenger Counts
  int adults = 1;
  int children = 0;
  int infants = 0;

  // Phase 2: Selection
  // Mocking selected flights for now
  Map<String, dynamic>? selectedOutboundFlight;
  Map<String, dynamic>? selectedReturnFlight;

  // Phase 3: Details
  List<Passenger> passengers = [];
  SeatMap? seatMap;

  // Active Tickets (Persisted)
  List<Ticket> activeTickets = [];

  void addTickets(List<Ticket> tickets) {
    activeTickets.addAll(tickets);
    notifyListeners();
  }

  void clearTickets() {
    activeTickets.clear();
    notifyListeners();
  }

  void removeTicket(Ticket ticket) {
    activeTickets.removeWhere((t) => t.ticketNumber == ticket.ticketNumber);
    notifyListeners();
  }

  void rescheduleTicket(Ticket ticket, DateTime newDate) {
    final index = activeTickets.indexWhere(
      (t) => t.ticketNumber == ticket.ticketNumber,
    );
    if (index != -1) {
      // Create new ticket with updated date and time
      // Keeling same time of day for simplicity, but updating the date part
      final oldDeparture = ticket.departureTime;
      final newDeparture = DateTime(
        newDate.year,
        newDate.month,
        newDate.day,
        oldDeparture.hour,
        oldDeparture.minute,
      );

      final oldArrival = ticket.arrivalTime;
      // Calculate duration to keep same flight length
      final duration = oldArrival.difference(oldDeparture);
      final newArrival = newDeparture.add(duration);

      final newTicket = ticket.copyWith(
        departureTime: newDeparture,
        arrivalTime: newArrival,
        // Optionally update ticket number to signify change?
        // ticketNumber: '${ticket.ticketNumber}-R',
      );

      activeTickets[index] = newTicket;
      notifyListeners();
    }
  }

  void startNewBooking() {
    // Reset wizard state but keep active tickets
    origin = null;
    destination = null;
    departureDate = null;
    returnDate = null;
    selectedOutboundFlight = null;
    selectedReturnFlight = null;
    passengers = [];
    adults = 1;
    children = 0;
    infants = 0;
    notifyListeners();
  }

  // Phase 4: Payment
  // ...

  void updateDepartureDate(DateTime date) {
    departureDate = date;
    notifyListeners();
  }

  void updateReturnDate(DateTime date) {
    returnDate = date;
    notifyListeners();
  }

  String? paymentMethod;
  String selectedFareTier = 'Basic'; // 'Basic' or 'Flex'
  List<String> selectedAncillaries = []; // e.g., ['baggage', 'insurance']

  void updatePassengerCount(int newAdults, int newChildren, int newInfants) {
    adults = newAdults;
    children = newChildren;
    infants = newInfants;

    // Resize passengers list if necessary or handled in UI
    notifyListeners();
  }

  void initializePassengers() {
    // Called when moving to Phase 3
    int total = adults + children + infants;
    if (passengers.length != total) {
      passengers = List.generate(total, (_) => Passenger());
      notifyListeners();
    }
    // Initialize seat map when passengers are created
    if (seatMap == null) {
      initializeSeatMap();
    }
  }

  void initializeSeatMap() {
    List<Seat> allSeats = [];

    // First Class: Rows 6-9, 1-1 configuration (A _ _ D)
    for (int row = 6; row <= 9; row++) {
      allSeats.add(
        Seat(id: '${row}A', row: row, column: 'A', seatClass: SeatClass.first),
      );
      // Aisle spacers
      allSeats.add(
        Seat(
          id: '${row}_AISLE1',
          row: row,
          column: '_',
          seatClass: SeatClass.first,
          isAisle: true,
        ),
      );
      allSeats.add(
        Seat(
          id: '${row}_AISLE2',
          row: row,
          column: '_',
          seatClass: SeatClass.first,
          isAisle: true,
        ),
      );
      allSeats.add(
        Seat(id: '${row}D', row: row, column: 'D', seatClass: SeatClass.first),
      );
    }

    // Business Class: Rows 1-5, 2-2 configuration (A B _ C D)
    for (int row = 1; row <= 5; row++) {
      allSeats.add(
        Seat(
          id: '${row}A',
          row: row,
          column: 'A',
          seatClass: SeatClass.business,
        ),
      );
      allSeats.add(
        Seat(
          id: '${row}B',
          row: row,
          column: 'B',
          seatClass: SeatClass.business,
        ),
      );
      // Aisle spacer
      allSeats.add(
        Seat(
          id: '${row}_AISLE',
          row: row,
          column: '_',
          seatClass: SeatClass.business,
          isAisle: true,
        ),
      );
      allSeats.add(
        Seat(
          id: '${row}C',
          row: row,
          column: 'C',
          seatClass: SeatClass.business,
        ),
      );
      allSeats.add(
        Seat(
          id: '${row}D',
          row: row,
          column: 'D',
          seatClass: SeatClass.business,
        ),
      );
    }

    // Economy Class: Rows 10-35, 3-3 configuration (A B C _ D E F)
    for (int row = 10; row <= 35; row++) {
      bool isExitRow = row == 15 || row == 16; // Exit rows

      allSeats.add(
        Seat(
          id: '${row}A',
          row: row,
          column: 'A',
          seatClass: SeatClass.economy,
          isExit: isExitRow,
        ),
      );
      allSeats.add(
        Seat(
          id: '${row}B',
          row: row,
          column: 'B',
          seatClass: SeatClass.economy,
          isExit: isExitRow,
        ),
      );
      allSeats.add(
        Seat(
          id: '${row}C',
          row: row,
          column: 'C',
          seatClass: SeatClass.economy,
          isExit: isExitRow,
        ),
      );
      // Aisle spacer
      allSeats.add(
        Seat(
          id: '${row}_AISLE',
          row: row,
          column: '_',
          seatClass: SeatClass.economy,
          isAisle: true,
        ),
      );
      allSeats.add(
        Seat(
          id: '${row}D',
          row: row,
          column: 'D',
          seatClass: SeatClass.economy,
          isExit: isExitRow,
        ),
      );
      allSeats.add(
        Seat(
          id: '${row}E',
          row: row,
          column: 'E',
          seatClass: SeatClass.economy,
          isExit: isExitRow,
        ),
      );
      allSeats.add(
        Seat(
          id: '${row}F',
          row: row,
          column: 'F',
          seatClass: SeatClass.economy,
          isExit: isExitRow,
        ),
      );
    }

    seatMap = SeatMap(
      seats: allSeats,
      totalRows: 35,
      columnsByClass: {
        SeatClass.first: ['A', '_', '_', 'D'],
        SeatClass.business: ['A', 'B', '_', 'C', 'D'],
        SeatClass.economy: ['A', 'B', 'C', '_', 'D', 'E', 'F'],
      },
    );

    notifyListeners();
  }

  void assignSeatToPassenger(int passengerIndex, String seatId) {
    if (passengerIndex < 0 || passengerIndex >= passengers.length) return;
    if (seatMap == null) return;

    final passenger = passengers[passengerIndex];

    // Release previous seat if any
    if (passenger.selectedSeat != null) {
      seatMap!.releaseSeat(passenger.selectedSeat!);
    }

    // Assign new seat
    passenger.selectedSeat = seatId;
    final seat = seatMap!.getSeatById(seatId);
    if (seat != null) {
      passenger.seatClass = seat.seatClass;
      seatMap!.occupySeat(seatId);
    }

    notifyListeners();
  }

  void releaseSeatFromPassenger(int passengerIndex) {
    if (passengerIndex < 0 || passengerIndex >= passengers.length) return;
    if (seatMap == null) return;

    final passenger = passengers[passengerIndex];
    if (passenger.selectedSeat != null) {
      seatMap!.releaseSeat(passenger.selectedSeat!);
      passenger.selectedSeat = null;
      passenger.seatClass = null;
      notifyListeners();
    }
  }
}
