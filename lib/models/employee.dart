import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  final String employeeId;
  final String firstName;
  final String lastName;
  final String email;
  final String department;
  final String position;
  final String phoneNumber;
  final bool isActive;
  final DateTime joiningDate;
  final WorkingHours workingHours;
  final DateTime createdAt;
  final DateTime updatedAt;

  Employee({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.department,
    required this.position,
    required this.phoneNumber,
    required this.isActive,
    required this.joiningDate,
    required this.workingHours,
    required this.createdAt,
    required this.updatedAt,
  });

  // Getter for full name
  String get fullName => '$firstName $lastName';

  // Factory constructor to create Employee from Firestore document
  factory Employee.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    return Employee(
      employeeId: data['employeeId'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
      department: data['department'] ?? '',
      position: data['position'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      isActive: data['isActive'] ?? true,
      joiningDate: (data['joiningDate'] as Timestamp).toDate(),
      workingHours: WorkingHours.fromMap(data['workingHours'] ?? {}),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  // Convert Employee to Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'employeeId': employeeId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'department': department,
      'position': position,
      'phoneNumber': phoneNumber,
      'isActive': isActive,
      'joiningDate': Timestamp.fromDate(joiningDate),
      'workingHours': workingHours.toMap(),
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  // Create a copy of Employee with updated fields
  Employee copyWith({
    String? employeeId,
    String? firstName,
    String? lastName,
    String? email,
    String? department,
    String? position,
    String? phoneNumber,
    bool? isActive,
    DateTime? joiningDate,
    WorkingHours? workingHours,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Employee(
      employeeId: employeeId ?? this.employeeId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      department: department ?? this.department,
      position: position ?? this.position,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isActive: isActive ?? this.isActive,
      joiningDate: joiningDate ?? this.joiningDate,
      workingHours: workingHours ?? this.workingHours,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class WorkingHours {
  final int standardHours;
  final bool flexibleTiming;
  final CoreHours coreHours;

  WorkingHours({
    required this.standardHours,
    required this.flexibleTiming,
    required this.coreHours,
  });

  factory WorkingHours.fromMap(Map<String, dynamic> map) {
    return WorkingHours(
      standardHours: map['standardHours'] ?? 8,
      flexibleTiming: map['flexibleTiming'] ?? true,
      coreHours: CoreHours.fromMap(map['coreHours'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'standardHours': standardHours,
      'flexibleTiming': flexibleTiming,
      'coreHours': coreHours.toMap(),
    };
  }
}

class CoreHours {
  final String start;
  final String end;

  CoreHours({
    required this.start,
    required this.end,
  });

  factory CoreHours.fromMap(Map<String, dynamic> map) {
    return CoreHours(
      start: map['start'] ?? '09:00',
      end: map['end'] ?? '17:00',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'end': end,
    };
  }
} 