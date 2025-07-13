import 'package:cloud_firestore/cloud_firestore.dart';

class Department {
  final String departmentId;
  final String name;
  final String description;
  final String? managerId;
  final int employeeCount;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Department({
    required this.departmentId,
    required this.name,
    required this.description,
    this.managerId,
    required this.employeeCount,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create Department from Firestore document
  factory Department.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    return Department(
      departmentId: data['departmentId'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      managerId: data['managerId'],
      employeeCount: data['employeeCount'] ?? 0,
      isActive: data['isActive'] ?? true,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  // Convert Department to Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'departmentId': departmentId,
      'name': name,
      'description': description,
      'managerId': managerId,
      'employeeCount': employeeCount,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  // Create a copy of Department with updated fields
  Department copyWith({
    String? departmentId,
    String? name,
    String? description,
    String? managerId,
    int? employeeCount,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Department(
      departmentId: departmentId ?? this.departmentId,
      name: name ?? this.name,
      description: description ?? this.description,
      managerId: managerId ?? this.managerId,
      employeeCount: employeeCount ?? this.employeeCount,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Check if department has a manager
  bool get hasManager => managerId != null && managerId!.isNotEmpty;

  // Get short description (first 50 characters)
  String get shortDescription {
    if (description.length <= 50) return description;
    return '${description.substring(0, 47)}...';
  }
} 