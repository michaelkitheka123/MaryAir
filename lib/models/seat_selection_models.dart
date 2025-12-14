import 'package:flutter/material.dart';

// Seat Class with complete aviation data
class AircraftSeat {
  final String seatNumber; // e.g., "12A", "12B", "1F"
  final String compartment; // "First", "Business", "Premium", "Economy"
  final SeatType seatType; // Window, Aisle, Middle, Exit Row, Bulkhead
  final SeatPosition seatPosition; // Location on aircraft
  final String fareClass; // "Y", "J", "F"
  final double price; // Seat price in base currency
  final double seatPitch; // Inches of legroom
  final double seatWidth; // Inches of seat width
  final bool isExitRow; // Exit row seat
  final bool isBulkhead; // Bulkhead seat
  final bool isExtraLegroom; // Extra legroom seat
  final bool isPreferred; // Preferred seating
  final bool hasPowerOutlet; // Has power outlet
  final bool hasInSeatScreen; // Has personal IFE
  final bool hasWifi; // Has Wi-Fi
  final bool isLavatoryAdjacent; // Near lavatory
  final bool isGalleyAdjacent; // Near galley
  final bool isInfantAllowed; // Can have infant
  final bool isBassinetLocation; // Bassinet location
  final bool isCrewRest; // Crew rest seat
  final bool isBlocked; // Blocked for operational reasons
  final bool isOccupied; // Already booked
  final String passengerName; // Assigned passenger name
  final String passengerId; // Passenger reference
  final DateTime? selectedAt; // When selected
  final List<String> amenities; // ["USB", "IFE", "Power", "WiFi"]
  final String seatMapCoordinate; // X,Y coordinates for mapping
  final double reclineAngle; // Degrees of recline
  final bool isLieFlat; // Lie-flat seat
  final String seatFeature; // "Suite", "Pod", "Sleeper"
  final String seatManufacturer; // "Recaro", "Zodiac", "Thompson"
  final String seatModel; // "Vega", "Aspire", "Cirrus"
  final int seatWeight; // Seat weight in lbs (for W&B)

  // Status
  bool isSelected;
  bool isAvailable;

  AircraftSeat({
    required this.seatNumber,
    required this.compartment,
    required this.seatType,
    required this.seatPosition,
    required this.fareClass,
    required this.price,
    required this.seatPitch,
    required this.seatWidth,
    required this.isExitRow,
    required this.isBulkhead,
    required this.isExtraLegroom,
    required this.isPreferred,
    required this.hasPowerOutlet,
    required this.hasInSeatScreen,
    required this.hasWifi,
    required this.isLavatoryAdjacent,
    required this.isGalleyAdjacent,
    required this.isInfantAllowed,
    required this.isBassinetLocation,
    required this.isCrewRest,
    required this.isBlocked,
    required this.isOccupied,
    required this.passengerName,
    required this.passengerId,
    this.selectedAt,
    required this.amenities,
    required this.seatMapCoordinate,
    required this.reclineAngle,
    required this.isLieFlat,
    required this.seatFeature,
    required this.seatManufacturer,
    required this.seatModel,
    required this.seatWeight,
    this.isSelected = false,
    this.isAvailable = true,
  });

  // Getters for quick checks
  bool get isPremiumSeat =>
      isExtraLegroom || isPreferred || compartment != "Economy";
  bool get hasRestrictions => !isInfantAllowed || isCrewRest || isBlocked;
  bool get isStandardSeat => !isPremiumSeat && !isExitRow && !isBulkhead;

  Map<String, dynamic> toMap() {
    return {
      'seatNumber': seatNumber,
      'compartment': compartment,
      'seatType': seatType.name,
      'seatPosition': seatPosition.name,
      'fareClass': fareClass,
      'price': price,
      'seatPitch': seatPitch,
      'seatWidth': seatWidth,
      'isExitRow': isExitRow,
      'isBulkhead': isBulkhead,
      'isExtraLegroom': isExtraLegroom,
      'isPreferred': isPreferred,
      'hasPowerOutlet': hasPowerOutlet,
      'hasInSeatScreen': hasInSeatScreen,
      'hasWifi': hasWifi,
      'isLavatoryAdjacent': isLavatoryAdjacent,
      'isGalleyAdjacent': isGalleyAdjacent,
      'isInfantAllowed': isInfantAllowed,
      'isBassinetLocation': isBassinetLocation,
      'isCrewRest': isCrewRest,
      'isBlocked': isBlocked,
      'isOccupied': isOccupied,
      'passengerName': passengerName,
      'passengerId': passengerId,
      'selectedAt': selectedAt?.toIso8601String(),
      'amenities': amenities,
      'seatMapCoordinate': seatMapCoordinate,
      'reclineAngle': reclineAngle,
      'isLieFlat': isLieFlat,
      'seatFeature': seatFeature,
      'seatManufacturer': seatManufacturer,
      'seatModel': seatModel,
      'seatWeight': seatWeight,
      'isSelected': isSelected,
      'isAvailable': isAvailable,
    };
  }

  factory AircraftSeat.fromMap(Map<String, dynamic> map) {
    return AircraftSeat(
      seatNumber: map['seatNumber'],
      compartment: map['compartment'],
      seatType: SeatType.values.firstWhere((e) => e.name == map['seatType']),
      seatPosition: SeatPosition.values.firstWhere(
        (e) => e.name == map['seatPosition'],
      ),
      fareClass: map['fareClass'],
      price: map['price'],
      seatPitch: map['seatPitch'],
      seatWidth: map['seatWidth'],
      isExitRow: map['isExitRow'],
      isBulkhead: map['isBulkhead'],
      isExtraLegroom: map['isExtraLegroom'],
      isPreferred: map['isPreferred'],
      hasPowerOutlet: map['hasPowerOutlet'],
      hasInSeatScreen: map['hasInSeatScreen'],
      hasWifi: map['hasWifi'],
      isLavatoryAdjacent: map['isLavatoryAdjacent'],
      isGalleyAdjacent: map['isGalleyAdjacent'],
      isInfantAllowed: map['isInfantAllowed'],
      isBassinetLocation: map['isBassinetLocation'],
      isCrewRest: map['isCrewRest'],
      isBlocked: map['isBlocked'],
      isOccupied: map['isOccupied'],
      passengerName: map['passengerName'],
      passengerId: map['passengerId'],
      selectedAt: map['selectedAt'] != null
          ? DateTime.parse(map['selectedAt'])
          : null,
      amenities: List<String>.from(map['amenities']),
      seatMapCoordinate: map['seatMapCoordinate'],
      reclineAngle: map['reclineAngle'],
      isLieFlat: map['isLieFlat'],
      seatFeature: map['seatFeature'],
      seatManufacturer: map['seatManufacturer'],
      seatModel: map['seatModel'],
      seatWeight: map['seatWeight'],
      isSelected: map['isSelected'],
      isAvailable: map['isAvailable'],
    );
  }

  // Add copyWith method
  AircraftSeat copyWith({
    String? seatNumber,
    String? compartment,
    SeatType? seatType,
    SeatPosition? seatPosition,
    String? fareClass,
    double? price,
    double? seatPitch,
    double? seatWidth,
    bool? isExitRow,
    bool? isBulkhead,
    bool? isExtraLegroom,
    bool? isPreferred,
    bool? hasPowerOutlet,
    bool? hasInSeatScreen,
    bool? hasWifi,
    bool? isLavatoryAdjacent,
    bool? isGalleyAdjacent,
    bool? isInfantAllowed,
    bool? isBassinetLocation,
    bool? isCrewRest,
    bool? isBlocked,
    bool? isOccupied,
    String? passengerName,
    String? passengerId,
    DateTime? selectedAt,
    List<String>? amenities,
    String? seatMapCoordinate,
    double? reclineAngle,
    bool? isLieFlat,
    String? seatFeature,
    String? seatManufacturer,
    String? seatModel,
    int? seatWeight,
    bool? isSelected,
    bool? isAvailable,
  }) {
    return AircraftSeat(
      seatNumber: seatNumber ?? this.seatNumber,
      compartment: compartment ?? this.compartment,
      seatType: seatType ?? this.seatType,
      seatPosition: seatPosition ?? this.seatPosition,
      fareClass: fareClass ?? this.fareClass,
      price: price ?? this.price,
      seatPitch: seatPitch ?? this.seatPitch,
      seatWidth: seatWidth ?? this.seatWidth,
      isExitRow: isExitRow ?? this.isExitRow,
      isBulkhead: isBulkhead ?? this.isBulkhead,
      isExtraLegroom: isExtraLegroom ?? this.isExtraLegroom,
      isPreferred: isPreferred ?? this.isPreferred,
      hasPowerOutlet: hasPowerOutlet ?? this.hasPowerOutlet,
      hasInSeatScreen: hasInSeatScreen ?? this.hasInSeatScreen,
      hasWifi: hasWifi ?? this.hasWifi,
      isLavatoryAdjacent: isLavatoryAdjacent ?? this.isLavatoryAdjacent,
      isGalleyAdjacent: isGalleyAdjacent ?? this.isGalleyAdjacent,
      isInfantAllowed: isInfantAllowed ?? this.isInfantAllowed,
      isBassinetLocation: isBassinetLocation ?? this.isBassinetLocation,
      isCrewRest: isCrewRest ?? this.isCrewRest,
      isBlocked: isBlocked ?? this.isBlocked,
      isOccupied: isOccupied ?? this.isOccupied,
      passengerName: passengerName ?? this.passengerName,
      passengerId: passengerId ?? this.passengerId,
      selectedAt: selectedAt ?? this.selectedAt,
      amenities: amenities ?? this.amenities,
      seatMapCoordinate: seatMapCoordinate ?? this.seatMapCoordinate,
      reclineAngle: reclineAngle ?? this.reclineAngle,
      isLieFlat: isLieFlat ?? this.isLieFlat,
      seatFeature: seatFeature ?? this.seatFeature,
      seatManufacturer: seatManufacturer ?? this.seatManufacturer,
      seatModel: seatModel ?? this.seatModel,
      seatWeight: seatWeight ?? this.seatWeight,
      isSelected: isSelected ?? this.isSelected,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}

enum SeatType {
  window('Window Seat', Icons.looks_one),
  aisle('Aisle Seat', Icons.looks_two),
  middle('Middle Seat', Icons.looks_3),
  suite('Suite', Icons.king_bed),
  pod('Pod', Icons.hotel),
  sleeper('Sleeper', Icons.bed),
  extraExit('Extra Exit Row', Icons.exit_to_app),
  bulkhead('Bulkhead', Icons.border_top);

  final String displayName;
  final IconData icon;

  const SeatType(this.displayName, this.icon);
}

enum SeatPosition {
  forward('Forward Cabin'),
  mid('Mid Cabin'),
  aft('Aft Cabin'),
  upperDeck('Upper Deck'),
  lowerDeck('Lower Deck');

  final String displayName;

  const SeatPosition(this.displayName);
}

// Aircraft Cabin Configuration
class AircraftCabin {
  final String aircraftType; // "B77W", "A359", "B738"
  final String registration; // "N12345"
  final String airlineCode; // "AA", "DL", "UA"
  final String configurationId; // "77W-J20-W56-Y300"
  final List<CabinSection> sections;
  final int totalSeats;
  final Map<String, dynamic> seatMap; // SVG/JSON seat map
  final DateTime lastUpdated;
  final String version;
  final String cabinLayout; // "2-4-2", "3-3", "1-2-1"

  AircraftCabin({
    required this.aircraftType,
    required this.registration,
    required this.airlineCode,
    required this.configurationId,
    required this.sections,
    required this.totalSeats,
    required this.seatMap,
    required this.lastUpdated,
    required this.version,
    required this.cabinLayout,
  });

  int get availableSeats => sections.fold(
    0,
    (sum, section) =>
        sum + section.seats.where((seat) => seat.isAvailable).length,
  );
}

class CabinSection {
  final String name; // "First", "Business", "Premium", "Economy"
  final int startRow;
  final int endRow;
  final String seatArrangement; // "1-2-1", "2-2-2", "3-3-3"
  final List<AircraftSeat> seats;
  final Color sectionColor;
  final double basePrice;
  final List<String> amenities;

  CabinSection({
    required this.name,
    required this.startRow,
    required this.endRow,
    required this.seatArrangement,
    required this.seats,
    required this.sectionColor,
    required this.basePrice,
    required this.amenities,
  });
}

// Passenger Information (Renamed to prevent conflict with core model)
class SeatPassenger {
  final String id;
  final String firstName;
  final String lastName;
  final String pnr; // Passenger Name Record
  final String frequentFlyerNumber;
  final String frequentFlyerTier;
  final bool hasSpecialAssistance;
  final List<String> specialRequests;
  final String mealPreference;
  final AircraftSeat? assignedSeat;
  final String ticketNumber;
  final String fareBasis;

  SeatPassenger({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.pnr,
    required this.frequentFlyerNumber,
    required this.frequentFlyerTier,
    required this.hasSpecialAssistance,
    required this.specialRequests,
    required this.mealPreference,
    this.assignedSeat,
    required this.ticketNumber,
    required this.fareBasis,
  });
}

// Seat Selection Rules
class SeatSelectionRules {
  final bool allowMultipleSeats;
  final bool allowFamilySeating;
  final bool allowExitRowForMinors;
  final bool allowBulkheadForInfants;
  final bool allowPremiumUpgrade;
  final double maxSeatSelectionTime; // Minutes
  final List<String> restrictedSeats; // Always blocked
  final Map<String, dynamic> pricingRules;
  final List<String> blockedRows; // For operational reasons
  final bool allowSeatChangeAfterSelection;

  SeatSelectionRules({
    this.allowMultipleSeats = true,
    this.allowFamilySeating = true,
    this.allowExitRowForMinors = false,
    this.allowBulkheadForInfants = true,
    this.allowPremiumUpgrade = true,
    this.maxSeatSelectionTime = 10.0,
    required this.restrictedSeats,
    required this.pricingRules,
    required this.blockedRows,
    this.allowSeatChangeAfterSelection = false,
  });
}
