import 'package:cloud_firestore/cloud_firestore.dart';

class AppSettings {
  final WorkingHoursRules workingHours;
  final BreakRules breakRules;
  final GeofencingSettings geofencing;
  final NotificationSettings notifications;

  AppSettings({
    required this.workingHours,
    required this.breakRules,
    required this.geofencing,
    required this.notifications,
  });

  // Factory constructor to create AppSettings from Firestore document
  factory AppSettings.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    return AppSettings(
      workingHours: WorkingHoursRules.fromMap(data['workingHours'] ?? {}),
      breakRules: BreakRules.fromMap(data['breakRules'] ?? {}),
      geofencing: GeofencingSettings.fromMap(data['geofencing'] ?? {}),
      notifications: NotificationSettings.fromMap(data['notifications'] ?? {}),
    );
  }

  // Convert AppSettings to Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'workingHours': workingHours.toMap(),
      'breakRules': breakRules.toMap(),
      'geofencing': geofencing.toMap(),
      'notifications': notifications.toMap(),
    };
  }

  // Create a copy of AppSettings with updated fields
  AppSettings copyWith({
    WorkingHoursRules? workingHours,
    BreakRules? breakRules,
    GeofencingSettings? geofencing,
    NotificationSettings? notifications,
  }) {
    return AppSettings(
      workingHours: workingHours ?? this.workingHours,
      breakRules: breakRules ?? this.breakRules,
      geofencing: geofencing ?? this.geofencing,
      notifications: notifications ?? this.notifications,
    );
  }
}

class WorkingHoursRules {
  final int standardHours;
  final int maxOvertimeHours;
  final int graceMinutes;

  WorkingHoursRules({
    required this.standardHours,
    required this.maxOvertimeHours,
    required this.graceMinutes,
  });

  factory WorkingHoursRules.fromMap(Map<String, dynamic> map) {
    return WorkingHoursRules(
      standardHours: map['standardHours'] ?? 8,
      maxOvertimeHours: map['maxOvertimeHours'] ?? 4,
      graceMinutes: map['graceMinutes'] ?? 15,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'standardHours': standardHours,
      'maxOvertimeHours': maxOvertimeHours,
      'graceMinutes': graceMinutes,
    };
  }

  // Get standard hours in minutes
  int get standardHoursInMinutes => standardHours * 60;

  // Get max overtime in minutes
  int get maxOvertimeInMinutes => maxOvertimeHours * 60;
}

class BreakRules {
  final int maxBreakSessions;
  final int maxBreakMinutes;

  BreakRules({
    required this.maxBreakSessions,
    required this.maxBreakMinutes,
  });

  factory BreakRules.fromMap(Map<String, dynamic> map) {
    return BreakRules(
      maxBreakSessions: map['maxBreakSessions'] ?? 3,
      maxBreakMinutes: map['maxBreakMinutes'] ?? 90,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'maxBreakSessions': maxBreakSessions,
      'maxBreakMinutes': maxBreakMinutes,
    };
  }

  // Get max break hours
  double get maxBreakHours => maxBreakMinutes / 60.0;
}

class GeofencingSettings {
  final bool enabled;
  final int radius; // in meters

  GeofencingSettings({
    required this.enabled,
    required this.radius,
  });

  factory GeofencingSettings.fromMap(Map<String, dynamic> map) {
    return GeofencingSettings(
      enabled: map['enabled'] ?? true,
      radius: map['radius'] ?? 100,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'radius': radius,
    };
  }

  // Get radius in kilometers
  double get radiusInKm => radius / 1000.0;
}

class NotificationSettings {
  final bool reminderEnabled;
  final int reminderTime; // in minutes

  NotificationSettings({
    required this.reminderEnabled,
    required this.reminderTime,
  });

  factory NotificationSettings.fromMap(Map<String, dynamic> map) {
    return NotificationSettings(
      reminderEnabled: map['reminderEnabled'] ?? true,
      reminderTime: map['reminderTime'] ?? 30,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reminderEnabled': reminderEnabled,
      'reminderTime': reminderTime,
    };
  }

  // Get reminder time in seconds
  int get reminderTimeInSeconds => reminderTime * 60;
} 