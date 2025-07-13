import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../services/attendance_service.dart';
import '../services/firebase_service.dart';
import '../services/location_service.dart';

final attendanceProvider = ChangeNotifierProvider<AttendanceProvider>((ref) => AttendanceProvider());

class AttendanceProvider extends ChangeNotifier {
  AttendanceSession? _currentSession;
  DailyAttendance? _todayAttendance;
  List<DailyAttendance> _monthlyAttendance = [];
  MonthlyAttendanceSummary? _monthlySummary;
  bool _isLoading = false;
  String? _error;

  // Getters
  AttendanceSession? get currentSession => _currentSession;
  DailyAttendance? get todayAttendance => _todayAttendance;
  List<DailyAttendance> get monthlyAttendance => _monthlyAttendance;
  MonthlyAttendanceSummary? get monthlySummary => _monthlySummary;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isClockedIn => _currentSession != null && _currentSession!.sessionType == SessionType.work;
  bool get isOnBreak => _currentSession != null && _currentSession!.sessionType == SessionType.breakTime;

  // Initialize attendance data for a user
  Future<void> initializeAttendance(String employeeId) async {
    await Future.wait([
      loadCurrentSession(employeeId),
      loadTodayAttendance(employeeId),
    ]);
  }

  // Load current session
  Future<void> loadCurrentSession(String employeeId) async {
    try {
      _isLoading = true;
      notifyListeners();

      _currentSession = await AttendanceService.instance.getCurrentSession(employeeId);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load current session';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load today's attendance
  Future<void> loadTodayAttendance(String employeeId) async {
    try {
      _isLoading = true;
      notifyListeners();

      _todayAttendance = await AttendanceService.instance.getTodayAttendance(employeeId);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load today\'s attendance';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load monthly attendance
  Future<void> loadMonthlyAttendance(String employeeId, int year, int month) async {
    try {
      _isLoading = true;
      notifyListeners();

      _monthlyAttendance = await AttendanceService.instance.getMonthlyAttendance(employeeId, year, month);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load monthly attendance';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load monthly summary
  Future<void> loadMonthlySummary(String employeeId, int year, int month) async {
    try {
      _isLoading = true;
      notifyListeners();

      _monthlySummary = await AttendanceService.instance.getMonthlySummary(employeeId, year, month);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load monthly summary';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clock in
  Future<bool> clockIn({
    required String employeeId,
    required ClockMethod method,
    String? notes,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final session = await AttendanceService.instance.clockIn(
        employeeId: employeeId,
        method: method,
        notes: notes,
      );

      if (session != null) {
        _currentSession = session;
        await loadTodayAttendance(employeeId);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Failed to clock in';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Clock out
  Future<bool> clockOut({
    required String employeeId,
    required ClockMethod method,
    String? notes,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final session = await AttendanceService.instance.clockOut(
        employeeId: employeeId,
        method: method,
        notes: notes,
      );

      if (session != null) {
        _currentSession = null;
        await loadTodayAttendance(employeeId);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Failed to clock out';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Start break
  Future<bool> startBreak({
    required String employeeId,
    required ClockMethod method,
    String? notes,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final session = await AttendanceService.instance.startBreak(
        employeeId: employeeId,
        method: method,
        notes: notes,
      );

      if (session != null) {
        _currentSession = session;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Failed to start break';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // End break
  Future<bool> endBreak({
    required String employeeId,
    required ClockMethod method,
    String? notes,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final session = await AttendanceService.instance.endBreak(
        employeeId: employeeId,
        method: method,
        notes: notes,
      );

      if (session != null) {
        // After ending break, check if there's a work session
        await loadCurrentSession(employeeId);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Failed to end break';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Refresh attendance data
  Future<void> refreshAttendance(String employeeId) async {
    await Future.wait([
      loadCurrentSession(employeeId),
      loadTodayAttendance(employeeId),
    ]);
  }

  // Get attendance for specific date
  Future<DailyAttendance?> getAttendanceForDate(String employeeId, DateTime date) async {
    try {
      final dateStr = FirebaseService.formatDate(date);
      return await FirebaseService.getDailyAttendance(employeeId, dateStr);
    } catch (e) {
      _error = 'Failed to get attendance for date';
      notifyListeners();
      return null;
    }
  }

  // Get sessions for specific date
  Future<List<AttendanceSession>> getSessionsForDate(String employeeId, DateTime date) async {
    try {
      return await FirebaseService.getSessionsForDate(employeeId, date);
    } catch (e) {
      _error = 'Failed to get sessions for date';
      notifyListeners();
      return [];
    }
  }

  // Check if user is at office (geofencing)
  Future<bool> isAtOffice(Location officeLocation, int radiusInMeters) async {
    try {
      return await LocationService.instance.isAtOffice(officeLocation, radiusInMeters);
    } catch (e) {
      _error = 'Failed to check office location';
      notifyListeners();
      return false;
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Get formatted current session duration
  String get currentSessionDuration {
    if (_currentSession?.clockIn != null) {
      final now = DateTime.now();
      final duration = now.difference(_currentSession!.clockIn!);
      final hours = duration.inHours;
      final minutes = duration.inMinutes % 60;
      return '${hours}h ${minutes}m';
    }
    return '0h 0m';
  }

  // Get formatted today's work duration
  String get todayWorkDuration {
    if (_todayAttendance != null) {
      return _todayAttendance!.formattedWorkDuration;
    }
    return '0h 0m';
  }

  // Get formatted today's break duration
  String get todayBreakDuration {
    if (_todayAttendance != null) {
      return _todayAttendance!.formattedBreakDuration;
    }
    return '0h 0m';
  }

  // Get today's status
  String get todayStatus {
    if (_todayAttendance != null) {
      switch (_todayAttendance!.status) {
        case AttendanceStatus.present:
          return 'Present';
        case AttendanceStatus.absent:
          return 'Absent';
        case AttendanceStatus.halfDay:
          return 'Half Day';
        case AttendanceStatus.leave:
          return 'Leave';
      }
    }
    return 'Not Available';
  }

  // Get current session type
  String get currentSessionType {
    if (_currentSession != null) {
      switch (_currentSession!.sessionType) {
        case SessionType.work:
          return 'Work';
        case SessionType.breakTime:
          return 'Break';
        case SessionType.lunch:
          return 'Lunch';
        case SessionType.meeting:
          return 'Meeting';
      }
    }
    return 'None';
  }

  // Get current session start time
  String get currentSessionStartTime {
    if (_currentSession?.clockIn != null) {
      final time = _currentSession!.clockIn!;
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
    return '--:--';
  }

  // Get today's first clock in time
  String get todayFirstClockIn {
    if (_todayAttendance?.firstClockIn != null) {
      final time = _todayAttendance!.firstClockIn!;
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
    return '--:--';
  }

  // Get today's last clock out time
  String get todayLastClockOut {
    if (_todayAttendance?.lastClockOut != null) {
      final time = _todayAttendance!.lastClockOut!;
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
    return '--:--';
  }

  // Check if today's attendance is complete
  bool get isTodayComplete {
    return _todayAttendance?.isComplete ?? false;
  }

  // Get monthly attendance percentage
  double get monthlyAttendancePercentage {
    if (_monthlySummary != null) {
      return _monthlySummary!.attendancePercentage;
    }
    return 0.0;
  }

  // Get monthly total work hours
  String get monthlyTotalWorkHours {
    if (_monthlySummary != null) {
      return _monthlySummary!.formattedTotalWorkHours;
    }
    return '0h 0m';
  }

  // Get monthly overtime hours
  String get monthlyOvertimeHours {
    if (_monthlySummary != null) {
      return _monthlySummary!.formattedOvertimeHours;
    }
    return '0h 0m';
  }
} 