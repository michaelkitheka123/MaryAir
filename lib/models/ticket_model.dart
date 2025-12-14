import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket {
  final String passengerId;
  final String passengerName;
  final String nationality; // e.g., "US", "KE", "GB"
  final String? profileImageUrl; // User's uploaded image
  final dynamic profileImageBytes; // Uint8List for local, String for web path
  final String origin;
  final String originName;
  final String originCountry;
  final String originLanguage;
  final String destination;
  final String destinationName;
  final String destinationCountry;
  final String destinationLanguage;
  final String flightNumber;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final String cabinClass;
  final String seatNumber;
  final String boardingGroup;
  final String terminal;
  final String gate;
  final String bookingReference;
  final double price;
  final String airlineCode;
  final String? specialRequests;
  final String frequentFlyerNumber;
  final String fareClass;
  final bool isRoundTrip;
  final String ticketNumber;

  Ticket({
    required this.passengerId,
    required this.passengerName,
    required this.nationality,
    this.profileImageUrl,
    this.profileImageBytes,
    required this.origin,
    required this.originName,
    required this.originCountry,
    required this.originLanguage,
    required this.destination,
    required this.destinationName,
    required this.destinationCountry,
    required this.destinationLanguage,
    required this.flightNumber,
    required this.departureTime,
    required this.arrivalTime,
    required this.cabinClass,
    required this.seatNumber,
    required this.boardingGroup,
    required this.terminal,
    required this.gate,
    required this.bookingReference,
    required this.price,
    required this.airlineCode,
    this.specialRequests,
    required this.frequentFlyerNumber,
    required this.fareClass,
    required this.isRoundTrip,
    required this.ticketNumber,
    this.passengerStatus = 'ADT',
    this.frequentFlyerStatus = 'NONE',
    this.equipment = 'Unknown',
    this.baggageAllowance = '0PC',
    this.taxes = 0.0,
    this.formOfPayment = 'CASH',
    DateTime? boardingTime,
    DateTime? ticketIssueDate,
  }) : this.boardingTime =
           boardingTime ?? departureTime.subtract(const Duration(minutes: 40)),
       this.ticketIssueDate = ticketIssueDate ?? DateTime.now();

  final String passengerStatus;
  final String frequentFlyerStatus;
  final String equipment;
  final String baggageAllowance;
  final double taxes;
  final String formOfPayment;
  final DateTime boardingTime;
  final DateTime ticketIssueDate;

  // Factory to create from basic data for rapid prototyping
  factory Ticket.create({
    required String pnr,
    required String flightNumber,
    required String origin,
    required String destination,
    required DateTime departureTime,
    required DateTime arrivalTime,
    required String passengerName,
    required String seatNumber,
    required String cabinClass,
    // Defaults for new fields
    String nationality = 'KE',
    String originCountry = 'Kenya',
    String originLanguage = 'sw',
    String destinationCountry = 'Destination',
    String destinationLanguage = 'en',
    dynamic profileImageBytes,
  }) {
    String group = '3';
    if (cabinClass.toLowerCase().contains('first'))
      group = '1';
    else if (cabinClass.toLowerCase().contains('business'))
      group = '2';

    return Ticket(
      passengerId: '',
      passengerName: passengerName,
      nationality: nationality,
      profileImageBytes: profileImageBytes,
      origin: origin,
      originName: _getCityName(origin),
      originCountry: originCountry,
      originLanguage: originLanguage,
      destination: destination,
      destinationName: _getCityName(destination),
      destinationCountry: destinationCountry,
      destinationLanguage: destinationLanguage,
      flightNumber: flightNumber,
      departureTime: departureTime,
      arrivalTime: arrivalTime,
      cabinClass: cabinClass,
      seatNumber: seatNumber,
      boardingGroup: group,
      terminal: '1A', // Realistic default
      gate: 'B15', // Realistic default
      bookingReference: pnr,
      price: 2450.00, // Mocked realistic price
      airlineCode: flightNumber.substring(0, 2),
      frequentFlyerNumber: 'MA123456789',
      fareClass: cabinClass.startsWith('B') ? 'J' : 'Y',
      isRoundTrip: false,
      ticketNumber: '014-${DateTime.now().millisecondsSinceEpoch}',
      // New realistic fields
      passengerStatus: 'ADT', // Adult
      frequentFlyerStatus: 'SKYTEAM ELITE PLUS',
      equipment: 'B77W (BOEING 777-300ER)',
      baggageAllowance: '2PC @ 23KG',
      taxes: 385.50,
      formOfPayment: 'VISA ****1234',
      boardingTime: departureTime.subtract(const Duration(minutes: 40)),
      ticketIssueDate: DateTime.now().subtract(const Duration(days: 2)),
    );
  }

  static String _getCityName(String code) {
    const map = {
      'NBO': 'Nairobi',
      'MBA': 'Mombasa',
      'KIS': 'Kisumu',
      'ELD': 'Eldoret',
      'JRO': 'Kilimanjaro',
      'DXB': 'Dubai',
      'LHR': 'London',
      'JFK': 'New York',
    };
    return map[code] ?? code;
  }

  // Determine theme color based on cabin class and status
  Color get themeColor {
    switch (cabinClass.toLowerCase()) {
      case 'first':
        return const Color(0xFFD4AF37); // Gold for First Class
      case 'business':
        return const Color(0xFF0D47A1); // Deep Blue for Business
      case 'premium economy':
        return const Color(0xFF2E7D32); // Green for Premium Economy
      case 'economy':
      default:
        return const Color(0xFFEF5350); // Red for Economy
    }
  }

  // Get cabin class display name
  String get cabinClassDisplay {
    switch (cabinClass.toLowerCase()) {
      case 'first':
        return 'FIRST';
      case 'business':
        return 'BUSINESS';
      case 'premium economy':
        return 'PREMIUM';
      case 'economy':
        return 'ECONOMY';
      default:
        return cabinClass.toUpperCase();
    }
  }

  // Format time
  String get departureTimeFormatted {
    return '${departureTime.hour.toString().padLeft(2, '0')}:${departureTime.minute.toString().padLeft(2, '0')}';
  }

  String get arrivalTimeFormatted {
    return '${arrivalTime.hour.toString().padLeft(2, '0')}:${arrivalTime.minute.toString().padLeft(2, '0')}';
  }

  String get dateFormatted {
    return '${departureTime.day.toString().padLeft(2, '0')}/${departureTime.month.toString().padLeft(2, '0')}';
  }

  // Calculate flight duration
  Duration get flightDuration => arrivalTime.difference(departureTime);

  String get flightDurationFormatted {
    final hours = flightDuration.inHours;
    final minutes = flightDuration.inMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  // Generate QR code data
  String get qrData {
    return json.encode({
      'ticketNumber': ticketNumber,
      'passengerName': passengerName,
      'flightNumber': flightNumber,
      'departure': origin,
      'destination': destination,
      'date': dateFormatted,
      'time': departureTimeFormatted,
      'seat': seatNumber,
      'gate': gate,
      'boardingGroup': boardingGroup,
      'bookingReference': bookingReference,
      'frequentFlyer': frequentFlyerNumber,
    });
  }

  Ticket copyWith({
    String? passengerId,
    String? passengerName,
    String? nationality,
    String? profileImageUrl,
    dynamic profileImageBytes,
    String? origin,
    String? originName,
    String? originCountry,
    String? originLanguage,
    String? destination,
    String? destinationName,
    String? destinationCountry,
    String? destinationLanguage,
    String? flightNumber,
    DateTime? departureTime,
    DateTime? arrivalTime,
    String? cabinClass,
    String? seatNumber,
    String? boardingGroup,
    String? terminal,
    String? gate,
    String? bookingReference,
    double? price,
    String? airlineCode,
    String? specialRequests,
    String? frequentFlyerNumber,
    String? fareClass,
    bool? isRoundTrip,
    String? ticketNumber,
    String? passengerStatus,
    String? frequentFlyerStatus,
    String? equipment,
    String? baggageAllowance,
    double? taxes,
    String? formOfPayment,
    DateTime? boardingTime,
    DateTime? ticketIssueDate,
  }) {
    return Ticket(
      passengerId: passengerId ?? this.passengerId,
      passengerName: passengerName ?? this.passengerName,
      nationality: nationality ?? this.nationality,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      profileImageBytes: profileImageBytes ?? this.profileImageBytes,
      origin: origin ?? this.origin,
      originName: originName ?? this.originName,
      originCountry: originCountry ?? this.originCountry,
      originLanguage: originLanguage ?? this.originLanguage,
      destination: destination ?? this.destination,
      destinationName: destinationName ?? this.destinationName,
      destinationCountry: destinationCountry ?? this.destinationCountry,
      destinationLanguage: destinationLanguage ?? this.destinationLanguage,
      flightNumber: flightNumber ?? this.flightNumber,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      cabinClass: cabinClass ?? this.cabinClass,
      seatNumber: seatNumber ?? this.seatNumber,
      boardingGroup: boardingGroup ?? this.boardingGroup,
      terminal: terminal ?? this.terminal,
      gate: gate ?? this.gate,
      bookingReference: bookingReference ?? this.bookingReference,
      price: price ?? this.price,
      airlineCode: airlineCode ?? this.airlineCode,
      specialRequests: specialRequests ?? this.specialRequests,
      frequentFlyerNumber: frequentFlyerNumber ?? this.frequentFlyerNumber,
      fareClass: fareClass ?? this.fareClass,
      isRoundTrip: isRoundTrip ?? this.isRoundTrip,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      passengerStatus: passengerStatus ?? this.passengerStatus,
      frequentFlyerStatus: frequentFlyerStatus ?? this.frequentFlyerStatus,
      equipment: equipment ?? this.equipment,
      baggageAllowance: baggageAllowance ?? this.baggageAllowance,
      taxes: taxes ?? this.taxes,
      formOfPayment: formOfPayment ?? this.formOfPayment,
      boardingTime: boardingTime ?? this.boardingTime,
      ticketIssueDate: ticketIssueDate ?? this.ticketIssueDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'passengerId': passengerId,
      'passengerName': passengerName,
      'nationality': nationality,
      'origin': origin,
      'destination': destination,
      'flightNumber': flightNumber,
      'departureTime': departureTime.toIso8601String(),
      'arrivalTime': arrivalTime.toIso8601String(),
      'cabinClass': cabinClass,
      'seatNumber': seatNumber,
      'bookingReference': bookingReference,
      'price': price,
      'airlineCode': airlineCode,
      'ticketNumber': ticketNumber,
      'passengerStatus': passengerStatus,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
