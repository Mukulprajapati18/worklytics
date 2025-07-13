import 'package:cloud_firestore/cloud_firestore.dart';

class MonthlyAttendanceSummary {
  final String employeeId;
  final int year;
  final int month;
  final int totalWorkingDays;
  final int presentDays;
  final int absentDays;
  final int lateArrivals;
  final int earlyDepartures;
  final double totalWorkHours;
  final double totalBreakHours;
  final double overtimeHours;
  final double averageWorkHours;
  final DateTime createdAt;
  final DateTime updatedAt;

  MonthlyAttendanceSummary({
    required this.employeeId,
    required this.year,
    required this.month,
    required this.totalWorkingDays,
    required this.presentDays,
    required this.absentDays,
    required this.lateArrivals,
    required this.earlyDepartures,
    required this.totalWorkHours,
    required this.totalBreakHours,
    required this.overtimeHours,
    required this.averageWorkHours,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create MonthlyAttendanceSummary from Firestore document
  factory MonthlyAttendanceSummary.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    return MonthlyAttendanceSummary(
      employeeId: data['employeeId'] ?? '',
      year: data['year'] ?? 0,
      month: data['month'] ?? 0,
      totalWorkingDays: data['totalWorkingDays'] ?? 0,
      presentDays: data['presentDays'] ?? 0,
      absentDays: data['absentDays'] ?? 0,
      lateArrivals: data['lateArrivals'] ?? 0,
      earlyDepartures: data['earlyDepartures'] ?? 0,
      totalWorkHours: (data['totalWorkHours'] ?? 0).toDouble(),
      totalBreakHours: (data['totalBreakHours'] ?? 0).toDouble(),
      overtimeHours: (data['overtimeHours'] ?? 0).toDouble(),
      averageWorkHours: (data['averageWorkHours'] ?? 0).toDouble(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  // Convert MonthlyAttendanceSummary to Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'employeeId': employeeId,
      'year': year,
      'month': month,
      'totalWorkingDays': totalWorkingDays,
      'presentDays': presentDays,
      'absentDays': absentDays,
      'lateArrivals': lateArrivals,
      'earlyDepartures': earlyDepartures,
      'totalWorkHours': totalWorkHours,
      'totalBreakHours': totalBreakHours,
      'overtimeHours': overtimeHours,
      'averageWorkHours': averageWorkHours,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  // Create a copy of MonthlyAttendanceSummary with updated fields
  MonthlyAttendanceSummary copyWith({
    String? employeeId,
    int? year,
    int? month,
    int? totalWorkingDays,
    int? presentDays,
    int? absentDays,
    int? lateArrivals,
    int? earlyDepartures,
    double? totalWorkHours,
    double? totalBreakHours,
    double? overtimeHours,
    double? averageWorkHours,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MonthlyAttendanceSummary(
      employeeId: employeeId ?? this.employeeId,
      year: year ?? this.year,
      month: month ?? this.month,
      totalWorkingDays: totalWorkingDays ?? this.totalWorkingDays,
      presentDays: presentDays ?? this.presentDays,
      absentDays: absentDays ?? this.absentDays,
      lateArrivals: lateArrivals ?? this.lateArrivals,
      earlyDepartures: earlyDepartures ?? this.earlyDepartures,
      totalWorkHours: totalWorkHours ?? this.totalWorkHours,
      totalBreakHours: totalBreakHours ?? this.totalBreakHours,
      overtimeHours: overtimeHours ?? this.overtimeHours,
      averageWorkHours: averageWorkHours ?? this.averageWorkHours,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Get attendance percentage
  double get attendancePercentage {
    if (totalWorkingDays == 0) return 0.0;
    return (presentDays / totalWorkingDays) * 100;
  }

  // Get total hours (work + break)
  double get totalHours => totalWorkHours + totalBreakHours;

  // Get formatted total work hours
  String get formattedTotalWorkHours {
    int hours = totalWorkHours.toInt();
    int minutes = ((totalWorkHours - hours) * 60).round();
    return '${hours}h ${minutes}m';
  }

  // Get formatted overtime hours
  String get formattedOvertimeHours {
    int hours = overtimeHours.toInt();
    int minutes = ((overtimeHours - hours) * 60).round();
    return '${hours}h ${minutes}m';
  }

  // Get month name
  String get monthName {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  // Get document ID for Firestore
  String get documentId => '${employeeId}_${year}_${month.toString().padLeft(2, '0')}';
} 