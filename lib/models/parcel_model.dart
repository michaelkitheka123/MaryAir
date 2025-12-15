import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

class Parcel {
  final String id;
  final String senderName;
  final String senderContact;
  final String receiverName;
  final String receiverContact;

  final String description;
  final double weightKg;
  final String dimensions; // e.g., "30x20x10 cm"
  final String commodityType; // NEW: Electronics, Clothing, etc.
  final Uint8List? photoBytes; // For the picture column

  final String flightNumber;
  final DateTime departureDate;
  final String origin;
  final String destination;

  final double cost;
  final String status; // 'Pending', 'In Transit', 'Delivered'

  Parcel({
    required this.id,
    required this.senderName,
    required this.senderContact,
    required this.receiverName,
    required this.receiverContact,
    required this.description,
    required this.weightKg,
    required this.dimensions,
    required this.commodityType,
    this.photoBytes,
    required this.flightNumber,
    required this.departureDate,
    required this.origin,
    required this.destination,
    required this.cost,
    this.status = 'Pending',
  });

  // Factory for an empty/initial parcel
  factory Parcel.empty() {
    return Parcel(
      id: '',
      senderName: '',
      senderContact: '',
      receiverName: '',
      receiverContact: '',
      description: '',
      weightKg: 0.0,
      dimensions: '',
      commodityType: 'Others',
      flightNumber: '',
      departureDate: DateTime.now(),
      origin: '',
      destination: '',
      cost: 0.0,
    );
  }

  Parcel copyWith({
    String? id,
    String? senderName,
    String? senderContact,
    String? receiverName,
    String? receiverContact,
    String? description,
    double? weightKg,
    String? dimensions,
    String? commodityType,
    Uint8List? photoBytes,
    String? flightNumber,
    DateTime? departureDate,
    String? origin,
    String? destination,
    double? cost,
    String? status,
  }) {
    return Parcel(
      id: id ?? this.id,
      senderName: senderName ?? this.senderName,
      senderContact: senderContact ?? this.senderContact,
      receiverName: receiverName ?? this.receiverName,
      receiverContact: receiverContact ?? this.receiverContact,
      description: description ?? this.description,
      weightKg: weightKg ?? this.weightKg,
      dimensions: dimensions ?? this.dimensions,
      commodityType: commodityType ?? this.commodityType,
      photoBytes: photoBytes ?? this.photoBytes,
      flightNumber: flightNumber ?? this.flightNumber,
      departureDate: departureDate ?? this.departureDate,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      cost: cost ?? this.cost,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderName': senderName,
      'senderContact': senderContact,
      'receiverName': receiverName,
      'receiverContact': receiverContact,
      'description': description,
      'weightKg': weightKg,
      'dimensions': dimensions,
      'commodityType': commodityType,
      // 'photoBytes': photoBytes, // Consider uploading to storage and using URL in real app
      'flightNumber': flightNumber,
      'departureDate': departureDate.toIso8601String(),
      'origin': origin,
      'destination': destination,
      'cost': cost,
      'status': status,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
