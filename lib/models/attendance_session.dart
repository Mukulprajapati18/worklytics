import 'package:cloud_firestore/cloud_firestore.dart';

enum SessionType { work, breakTime, lunch, meeting }
enum ClockMethod { manual, biometric, qrCode }

class AttendanceSession {
  final String sessionId;
  final String employeeId;
  final DateTime date;
  final DateTime? clockIn;
  final DateTime? clockOut;
  final SessionType sessionType;
  final int? duration; // in minutes
  final Location? location;
  final ClockMethod clockInMethod;
  final ClockMethod? clockOutMethod;
  final bool isActive;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  AttendanceSession({
    required this.sessionId,
    required this.employeeId,
    required this.date,
    this.clockIn,
    this.clockOut,
    required this.sessionType,
    this.duration,
    this.location,
    required this.clockInMethod,
    this.clockOutMethod,
    required this.isActive,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create AttendanceSession from Firestore document
  factory AttendanceSession.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    return AttendanceSession(
      sessionId: data['sessionId'] ?? '',
      employeeId: data['employeeId'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      clockIn: data['clockIn'] != null ? (data['clockIn'] as Timestamp).toDate() : null,
      clockOut: data['clockOut'] != null ? (data['clockOut'] as Timestamp).toDate() : null,
      sessionType: SessionType.values.firstWhere(
        (e) => e.toString().split('.').last == data['sessionType'],
        orElse: () => SessionType.work,
      ),
      duration: data['duration'],
      location: data['location'] != null ? Location.fromMap(data['location']) : null,
      clockInMethod: ClockMethod.values.firstWhere(
        (e) => e.toString().split('.').last == data['clockInMethod'],
        orElse: () => ClockMethod.manual,
      ),
      clockOutMethod: data['clockOutMethod'] != null
          ? ClockMethod.values.firstWhere(
              (e) => e.toString().split('.').last == data['clockOutMethod'],
              orElse: () => ClockMethod.manual,
            )
          : null,
      isActive: data['isActive'] ?? false,
      notes: data['notes'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  // Convert AttendanceSession to Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'sessionId': sessionId,
      'employeeId': employeeId,
      'date': Timestamp.fromDate(date),
      'clockIn': clockIn != null ? Timestamp.fromDate(clockIn!) : null,
      'clockOut': clockOut != null ? Timestamp.fromDate(clockOut!) : null,
      'sessionType': sessionType.toString().split('.').last,
      'duration': duration,
      'location': location?.toMap(),
      'clockInMethod': clockInMethod.toString().split('.').last,
      'clockOutMethod': clockOutMethod?.toString().split('.').last,
      'isActive': isActive,
      'notes': notes,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  // Create a copy of AttendanceSession with updated fields
  AttendanceSession copyWith({
    String? sessionId,
    String? employeeId,
    DateTime? date,
    DateTime? clockIn,
    DateTime? clockOut,
    SessionType? sessionType,
    int? duration,
    Location? location,
    ClockMethod? clockInMethod,
    ClockMethod? clockOutMethod,
    bool? isActive,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AttendanceSession(
      sessionId: sessionId ?? this.sessionId,
      employeeId: employeeId ?? this.employeeId,
      date: date ?? this.date,
      clockIn: clockIn ?? this.clockIn,
      clockOut: clockOut ?? this.clockOut,
      sessionType: sessionType ?? this.sessionType,
      duration: duration ?? this.duration,
      location: location ?? this.location,
      clockInMethod: clockInMethod ?? this.clockInMethod,
      clockOutMethod: clockOutMethod ?? this.clockOutMethod,
      isActive: isActive ?? this.isActive,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Get duration in minutes if session is completed
  int? getDurationInMinutes() {
    if (clockIn != null && clockOut != null) {
      return clockOut!.difference(clockIn!).inMinutes;
    }
    return duration;
  }

  // Check if session is ongoing
  bool get isOngoing => isActive && clockIn != null && clockOut == null;
}

class Location {
  final double latitude;
  final double longitude;
  final String? address;

  Location({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      address: map['address'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }
} 