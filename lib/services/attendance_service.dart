import 'package:uuid/uuid.dart';
import '../models/models.dart';
import 'firebase_service.dart';
import 'location_service.dart';

class AttendanceService {
  static AttendanceService? _instance;
  static AttendanceService get instance => _instance ??= AttendanceService._internal();
  
  AttendanceService._internal();

  // Clock in for work
  Future<AttendanceSession?> clockIn({
    required String employeeId,
    required ClockMethod method,
    String? notes,
  }) async {
    try {
      final now = DateTime.now();
      final today = FirebaseService.formatDate(now);
      
      // Check if already clocked in
      final activeSession = await FirebaseService.getActiveSession(employeeId, now);
      if (activeSession != null) {
        throw Exception('Already clocked in for today');
      }

      // Get location if available
      Location? location;
      try {
        location = await LocationService.instance.getLocationWithAddress();
      } catch (e) {
        print('Could not get location: $e');
      }

      // Create new session
      final sessionId = FirebaseService.generateSessionId(employeeId, now);
      final session = AttendanceSession(
        sessionId: sessionId,
        employeeId: employeeId,
        date: now,
        clockIn: now,
        sessionType: SessionType.work,
        location: location,
        clockInMethod: method,
        isActive: true,
        notes: notes,
        createdAt: now,
        updatedAt: now,
      );

      // Save session to Firestore
      await FirebaseService.createAttendanceSession(session);

      // Update daily attendance
      await _updateDailyAttendance(employeeId, today, session);

      return session;
    } catch (e) {
      print('Error clocking in: $e');
      return null;
    }
  }

  // Clock out from work
  Future<AttendanceSession?> clockOut({
    required String employeeId,
    required ClockMethod method,
    String? notes,
  }) async {
    try {
      final now = DateTime.now();
      final today = FirebaseService.formatDate(now);
      
      // Get active session
      final activeSession = await FirebaseService.getActiveSession(employeeId, now);
      if (activeSession == null) {
        throw Exception('No active session found');
      }

      // Get location if available
      Location? location;
      try {
        location = await LocationService.instance.getLocationWithAddress();
      } catch (e) {
        print('Could not get location: $e');
      }

      // Update session
      final updatedSession = activeSession.copyWith(
        clockOut: now,
        clockOutMethod: method,
        isActive: false,
        duration: now.difference(activeSession.clockIn!).inMinutes,
        location: location ?? activeSession.location,
        notes: notes ?? activeSession.notes,
        updatedAt: now,
      );

      // Save updated session
      await FirebaseService.updateAttendanceSession(updatedSession);

      // Update daily attendance
      await _updateDailyAttendance(employeeId, today, updatedSession);

      return updatedSession;
    } catch (e) {
      print('Error clocking out: $e');
      return null;
    }
  }

  // Start break
  Future<AttendanceSession?> startBreak({
    required String employeeId,
    required ClockMethod method,
    String? notes,
  }) async {
    try {
      final now = DateTime.now();
      final today = FirebaseService.formatDate(now);
      
      // Check if already on break
      final activeSession = await FirebaseService.getActiveSession(employeeId, now);
      if (activeSession != null && activeSession.sessionType == SessionType.breakTime) {
        throw Exception('Already on break');
      }

      // Get location if available
      Location? location;
      try {
        location = await LocationService.instance.getLocationWithAddress();
      } catch (e) {
        print('Could not get location: $e');
      }

      // Create break session
      final sessionId = FirebaseService.generateSessionId(employeeId, now);
      final session = AttendanceSession(
        sessionId: sessionId,
        employeeId: employeeId,
        date: now,
        clockIn: now,
        sessionType: SessionType.breakTime,
        location: location,
        clockInMethod: method,
        isActive: true,
        notes: notes,
        createdAt: now,
        updatedAt: now,
      );

      // Save session
      await FirebaseService.createAttendanceSession(session);

      return session;
    } catch (e) {
      print('Error starting break: $e');
      return null;
    }
  }

  // End break
  Future<AttendanceSession?> endBreak({
    required String employeeId,
    required ClockMethod method,
    String? notes,
  }) async {
    try {
      final now = DateTime.now();
      
      // Get active break session
      final activeSession = await FirebaseService.getActiveSession(employeeId, now);
      if (activeSession == null || activeSession.sessionType != SessionType.breakTime) {
        throw Exception('No active break session found');
      }

      // Update session
      final updatedSession = activeSession.copyWith(
        clockOut: now,
        clockOutMethod: method,
        isActive: false,
        duration: now.difference(activeSession.clockIn!).inMinutes,
        notes: notes ?? activeSession.notes,
        updatedAt: now,
      );

      // Save updated session
      await FirebaseService.updateAttendanceSession(updatedSession);

      return updatedSession;
    } catch (e) {
      print('Error ending break: $e');
      return null;
    }
  }

  // Get today's attendance summary
  Future<DailyAttendance?> getTodayAttendance(String employeeId) async {
    try {
      final today = FirebaseService.formatDate(DateTime.now());
      return await FirebaseService.getDailyAttendance(employeeId, today);
    } catch (e) {
      print('Error getting today\'s attendance: $e');
      return null;
    }
  }

  // Get monthly attendance
  Future<List<DailyAttendance>> getMonthlyAttendance(String employeeId, int year, int month) async {
    try {
      return await FirebaseService.getMonthlyAttendance(employeeId, year, month);
    } catch (e) {
      print('Error getting monthly attendance: $e');
      return [];
    }
  }

  // Get monthly summary
  Future<MonthlyAttendanceSummary?> getMonthlySummary(String employeeId, int year, int month) async {
    try {
      return await FirebaseService.getMonthlySummary(employeeId, year, month);
    } catch (e) {
      print('Error getting monthly summary: $e');
      return null;
    }
  }

  // Calculate daily attendance from sessions
  Future<DailyAttendance> _calculateDailyAttendance(String employeeId, String date, List<AttendanceSession> sessions) async {
    final now = DateTime.now();
    final dateTime = FirebaseService.parseDate(date);
    
    int totalWorkMinutes = 0;
    int totalBreakMinutes = 0;
    DateTime? firstClockIn;
    DateTime? lastClockOut;
    List<String> sessionIds = [];
    bool isPresent = false;
    bool isLate = false;
    bool isEarlyOut = false;

    // Process sessions
    for (final session in sessions) {
      sessionIds.add(session.sessionId);
      
      if (session.clockIn != null) {
        if (firstClockIn == null || session.clockIn!.isBefore(firstClockIn)) {
          firstClockIn = session.clockIn;
        }
      }
      
      if (session.clockOut != null) {
        if (lastClockOut == null || session.clockOut!.isAfter(lastClockOut)) {
          lastClockOut = session.clockOut;
        }
      }

      // Calculate duration
      if (session.duration != null) {
        if (session.sessionType == SessionType.work) {
          totalWorkMinutes += session.duration!;
        } else if (session.sessionType == SessionType.breakTime) {
          totalBreakMinutes += session.duration!;
        }
      }

      // Check if present
      if (session.sessionType == SessionType.work && session.clockIn != null) {
        isPresent = true;
      }
    }

    // Determine attendance status
    AttendanceStatus status = AttendanceStatus.absent;
    if (isPresent) {
      if (totalWorkMinutes >= 240) { // 4 hours minimum for half day
        status = AttendanceStatus.present;
      } else {
        status = AttendanceStatus.halfDay;
      }
    }

    return DailyAttendance(
      date: date,
      employeeId: employeeId,
      totalWorkMinutes: totalWorkMinutes,
      totalBreakMinutes: totalBreakMinutes,
      totalSessions: sessions.length,
      firstClockIn: firstClockIn,
      lastClockOut: lastClockOut,
      isPresent: isPresent,
      isLate: isLate,
      isEarlyOut: isEarlyOut,
      status: status,
      sessionIds: sessionIds,
      createdAt: now,
      updatedAt: now,
    );
  }

  // Update daily attendance
  Future<void> _updateDailyAttendance(String employeeId, String date, AttendanceSession session) async {
    try {
      final sessions = await FirebaseService.getSessionsForDate(employeeId, FirebaseService.parseDate(date));
      final dailyAttendance = await _calculateDailyAttendance(employeeId, date, sessions);
      await FirebaseService.createDailyAttendance(dailyAttendance);
    } catch (e) {
      print('Error updating daily attendance: $e');
    }
  }

  // Check if employee is currently clocked in
  Future<bool> isClockedIn(String employeeId) async {
    try {
      final activeSession = await FirebaseService.getActiveSession(employeeId, DateTime.now());
      return activeSession != null && activeSession.sessionType == SessionType.work;
    } catch (e) {
      print('Error checking clock in status: $e');
      return false;
    }
  }

  // Check if employee is on break
  Future<bool> isOnBreak(String employeeId) async {
    try {
      final activeSession = await FirebaseService.getActiveSession(employeeId, DateTime.now());
      return activeSession != null && activeSession.sessionType == SessionType.breakTime;
    } catch (e) {
      print('Error checking break status: $e');
      return false;
    }
  }

  // Get current session
  Future<AttendanceSession?> getCurrentSession(String employeeId) async {
    try {
      return await FirebaseService.getActiveSession(employeeId, DateTime.now());
    } catch (e) {
      print('Error getting current session: $e');
      return null;
    }
  }
} 