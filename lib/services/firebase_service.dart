import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static const Uuid _uuid = Uuid();

  // Collection references
  static CollectionReference get _employeesCollection => _firestore.collection('employees');
  static CollectionReference get _departmentsCollection => _firestore.collection('departments');
  static CollectionReference get _attendanceSummaryCollection => _firestore.collection('attendance_summary');
  static CollectionReference get _appSettingsCollection => _firestore.collection('app_settings');

  // Employee Operations
  static Future<void> createEmployee(Employee employee) async {
    await _employeesCollection.doc(employee.employeeId).set(employee.toFirestore());
  }

  static Future<Employee?> getEmployee(String employeeId) async {
    final doc = await _employeesCollection.doc(employeeId).get();
    if (doc.exists) {
      return Employee.fromFirestore(doc);
    }
    return null;
  }

  static Future<List<Employee>> getAllEmployees() async {
    final querySnapshot = await _employeesCollection
        .where('isActive', isEqualTo: true)
        .orderBy('firstName')
        .get();
    
    return querySnapshot.docs
        .map((doc) => Employee.fromFirestore(doc))
        .toList();
  }

  static Future<List<Employee>> getEmployeesByDepartment(String department) async {
    final querySnapshot = await _employeesCollection
        .where('department', isEqualTo: department)
        .where('isActive', isEqualTo: true)
        .orderBy('firstName')
        .get();
    
    return querySnapshot.docs
        .map((doc) => Employee.fromFirestore(doc))
        .toList();
  }

  static Future<void> updateEmployee(Employee employee) async {
    await _employeesCollection.doc(employee.employeeId).update(employee.toFirestore());
  }

  static Future<void> deleteEmployee(String employeeId) async {
    await _employeesCollection.doc(employeeId).update({'isActive': false});
  }

  // Attendance Session Operations
  static Future<void> createAttendanceSession(AttendanceSession session) async {
    final year = session.date.year.toString();
    final month = session.date.month.toString().padLeft(2, '0');
    final date = session.date.day.toString().padLeft(2, '0');
    
    await _employeesCollection
        .doc(session.employeeId)
        .collection('attendance')
        .doc(year)
        .collection(month)
        .doc(date)
        .collection('sessions')
        .doc(session.sessionId)
        .set(session.toFirestore());
  }

  static Future<AttendanceSession?> getActiveSession(String employeeId, DateTime date) async {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final dateStr = date.day.toString().padLeft(2, '0');
    
    final querySnapshot = await _employeesCollection
        .doc(employeeId)
        .collection('attendance')
        .doc(year)
        .collection(month)
        .doc(dateStr)
        .collection('sessions')
        .where('isActive', isEqualTo: true)
        .limit(1)
        .get();
    
    if (querySnapshot.docs.isNotEmpty) {
      return AttendanceSession.fromFirestore(querySnapshot.docs.first);
    }
    return null;
  }

  static Future<List<AttendanceSession>> getSessionsForDate(String employeeId, DateTime date) async {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final dateStr = date.day.toString().padLeft(2, '0');
    
    final querySnapshot = await _employeesCollection
        .doc(employeeId)
        .collection('attendance')
        .doc(year)
        .collection(month)
        .doc(dateStr)
        .collection('sessions')
        .orderBy('clockIn', descending: false)
        .get();
    
    return querySnapshot.docs
        .map((doc) => AttendanceSession.fromFirestore(doc))
        .toList();
  }

  static Future<void> updateAttendanceSession(AttendanceSession session) async {
    final year = session.date.year.toString();
    final month = session.date.month.toString().padLeft(2, '0');
    final date = session.date.day.toString().padLeft(2, '0');
    
    await _employeesCollection
        .doc(session.employeeId)
        .collection('attendance')
        .doc(year)
        .collection(month)
        .doc(date)
        .collection('sessions')
        .doc(session.sessionId)
        .update(session.toFirestore());
  }

  // Daily Attendance Operations
  static Future<void> createDailyAttendance(DailyAttendance attendance) async {
    final year = attendance.date.split('-')[0];
    final month = attendance.date.split('-')[1];
    
    await _employeesCollection
        .doc(attendance.employeeId)
        .collection('attendance')
        .doc(year)
        .collection(month)
        .doc(attendance.date)
        .set(attendance.toFirestore());
  }

  static Future<DailyAttendance?> getDailyAttendance(String employeeId, String date) async {
    final year = date.split('-')[0];
    final month = date.split('-')[1];
    
    final doc = await _employeesCollection
        .doc(employeeId)
        .collection('attendance')
        .doc(year)
        .collection(month)
        .doc(date)
        .get();
    
    if (doc.exists) {
      return DailyAttendance.fromFirestore(doc);
    }
    return null;
  }

  static Future<List<DailyAttendance>> getMonthlyAttendance(String employeeId, int year, int month) async {
    final yearStr = year.toString();
    final monthStr = month.toString().padLeft(2, '0');
    
    final querySnapshot = await _employeesCollection
        .doc(employeeId)
        .collection('attendance')
        .doc(yearStr)
        .collection(monthStr)
        .orderBy('date', descending: true)
        .get();
    
    return querySnapshot.docs
        .map((doc) => DailyAttendance.fromFirestore(doc))
        .toList();
  }

  // Monthly Summary Operations
  static Future<void> createMonthlySummary(MonthlyAttendanceSummary summary) async {
    await _attendanceSummaryCollection.doc(summary.documentId).set(summary.toFirestore());
  }

  static Future<MonthlyAttendanceSummary?> getMonthlySummary(String employeeId, int year, int month) async {
    final documentId = '${employeeId}_${year}_${month.toString().padLeft(2, '0')}';
    final doc = await _attendanceSummaryCollection.doc(documentId).get();
    
    if (doc.exists) {
      return MonthlyAttendanceSummary.fromFirestore(doc);
    }
    return null;
  }

  static Future<List<MonthlyAttendanceSummary>> getYearlySummary(String employeeId, int year) async {
    final querySnapshot = await _attendanceSummaryCollection
        .where('employeeId', isEqualTo: employeeId)
        .where('year', isEqualTo: year)
        .orderBy('month', descending: false)
        .get();
    
    return querySnapshot.docs
        .map((doc) => MonthlyAttendanceSummary.fromFirestore(doc))
        .toList();
  }

  // Department Operations
  static Future<void> createDepartment(Department department) async {
    await _departmentsCollection.doc(department.departmentId).set(department.toFirestore());
  }

  static Future<Department?> getDepartment(String departmentId) async {
    final doc = await _departmentsCollection.doc(departmentId).get();
    if (doc.exists) {
      return Department.fromFirestore(doc);
    }
    return null;
  }

  static Future<List<Department>> getAllDepartments() async {
    final querySnapshot = await _departmentsCollection
        .where('isActive', isEqualTo: true)
        .orderBy('name')
        .get();
    
    return querySnapshot.docs
        .map((doc) => Department.fromFirestore(doc))
        .toList();
  }

  static Future<void> updateDepartment(Department department) async {
    await _departmentsCollection.doc(department.departmentId).update(department.toFirestore());
  }

  // App Settings Operations
  static Future<AppSettings?> getAppSettings() async {
    final doc = await _appSettingsCollection.doc('attendance_rules').get();
    if (doc.exists) {
      return AppSettings.fromFirestore(doc);
    }
    return null;
  }

  static Future<void> updateAppSettings(AppSettings settings) async {
    await _appSettingsCollection.doc('attendance_rules').set(settings.toFirestore());
  }

  // Utility Methods
  static String generateSessionId(String employeeId, DateTime date) {
    final dateStr = '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}';
    final uniqueId = _uuid.v4().substring(0, 8);
    return 'session_${dateStr}_$uniqueId';
  }

  static String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  static DateTime parseDate(String dateStr) {
    final parts = dateStr.split('-');
    return DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
  }

  // Authentication Methods
  static Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('Sign in error: $e');
      return null;
    }
  }

  static Future<UserCredential?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('Sign up error: $e');
      return null;
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static User? getCurrentUser() {
    return _auth.currentUser;
  }

  static Stream<User?> get authStateChanges => _auth.authStateChanges();
} 