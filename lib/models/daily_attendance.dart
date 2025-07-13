import 'package:cloud_firestore/cloud_firestore.dart';

enum AttendanceStatus { present, absent, halfDay, leave }

class DailyAttendance {
  final String date;
  final String employeeId;
  final int totalWorkMinutes;
  final int totalBreakMinutes;
  final int totalSessions;
  final DateTime? firstClockIn;
  final DateTime? lastClockOut;
  final bool isPresent;
  final bool isLate;
  final bool isEarlyOut;
  final AttendanceStatus status;
  final List<String> sessionIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  DailyAttendance({
    required this.date,
    required this.employeeId,
    required this.totalWorkMinutes,
    required this.totalBreakMinutes,
    required this.totalSessions,
    this.firstClockIn,
    this.lastClockOut,
    required this.isPresent,
    required this.isLate,
    required this.isEarlyOut,
    required this.status,
    required this.sessionIds,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create DailyAttendance from Firestore document
  factory DailyAttendance.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    return DailyAttendance(
      date: data['date'] ?? '',
      employeeId: data['employeeId'] ?? '',
      totalWorkMinutes: data['totalWorkMinutes'] ?? 0,
      totalBreakMinutes: data['totalBreakMinutes'] ?? 0,
      totalSessions: data['totalSessions'] ?? 0,
      firstClockIn: data['firstClockIn'] != null ? (data['firstClockIn'] as Timestamp).toDate() : null,
      lastClockOut: data['lastClockOut'] != null ? (data['lastClockOut'] as Timestamp).toDate() : null,
      isPresent: data['isPresent'] ?? false,
      isLate: data['isLate'] ?? false,
      isEarlyOut: data['isEarlyOut'] ?? false,
      status: AttendanceStatus.values.firstWhere(
        (e) => e.toString().split('.').last == data['status'],
        orElse: () => AttendanceStatus.absent,
      ),
      sessionIds: List<String>.from(data['sessionIds'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  // Convert DailyAttendance to Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'date': date,
      'employeeId': employeeId,
      'totalWorkMinutes': totalWorkMinutes,
      'totalBreakMinutes': totalBreakMinutes,
      'totalSessions': totalSessions,
      'firstClockIn': firstClockIn != null ? Timestamp.fromDate(firstClockIn!) : null,
      'lastClockOut': lastClockOut != null ? Timestamp.fromDate(lastClockOut!) : null,
      'isPresent': isPresent,
      'isLate': isLate,
      'isEarlyOut': isEarlyOut,
      'status': status.toString().split('.').last,
      'sessionIds': sessionIds,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  // Create a copy of DailyAttendance with updated fields
  DailyAttendance copyWith({
    String? date,
    String? employeeId,
    int? totalWorkMinutes,
    int? totalBreakMinutes,
    int? totalSessions,
    DateTime? firstClockIn,
    DateTime? lastClockOut,
    bool? isPresent,
    bool? isLate,
    bool? isEarlyOut,
    AttendanceStatus? status,
    List<String>? sessionIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DailyAttendance(
      date: date ?? this.date,
      employeeId: employeeId ?? this.employeeId,
      totalWorkMinutes: totalWorkMinutes ?? this.totalWorkMinutes,
      totalBreakMinutes: totalBreakMinutes ?? this.totalBreakMinutes,
      totalSessions: totalSessions ?? this.totalSessions,
      firstClockIn: firstClockIn ?? this.firstClockIn,
      lastClockOut: lastClockOut ?? this.lastClockOut,
      isPresent: isPresent ?? this.isPresent,
      isLate: isLate ?? this.isLate,
      isEarlyOut: isEarlyOut ?? this.isEarlyOut,
      status: status ?? this.status,
      sessionIds: sessionIds ?? this.sessionIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Get total work hours
  double get totalWorkHours => totalWorkMinutes / 60.0;

  // Get total break hours
  double get totalBreakHours => totalBreakMinutes / 60.0;

  // Get total hours (work + break)
  double get totalHours => (totalWorkMinutes + totalBreakMinutes) / 60.0;

  // Check if attendance is complete for the day
  bool get isComplete => lastClockOut != null;

  // Get formatted work duration
  String get formattedWorkDuration {
    int hours = totalWorkMinutes ~/ 60;
    int minutes = totalWorkMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  // Get formatted break duration
  String get formattedBreakDuration {
    int hours = totalBreakMinutes ~/ 60;
    int minutes = totalBreakMinutes % 60;
    return '${hours}h ${minutes}m';
  }
} 