import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/models.dart';
import '../services/firebase_service.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider());

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  Employee? _currentEmployee;
  bool _isLoading = true;
  String? _error;

  // Getters
  User? get currentUser => _currentUser;
  Employee? get currentEmployee => _currentEmployee;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;
  String? get error => _error;

  AuthProvider() {
    _initializeAuth();
  }

  // Initialize authentication state
  void _initializeAuth() {
    FirebaseService.authStateChanges.listen((User? user) async {
      _currentUser = user;
      if (user != null) {
        await _loadEmployeeData(user.uid);
      } else {
        _currentEmployee = null;
      }
      _isLoading = false;
      notifyListeners();
    });
  }

  // Load employee data from Firestore
  Future<void> _loadEmployeeData(String userId) async {
    try {
      _currentEmployee = await FirebaseService.getEmployee(userId);
      notifyListeners();
    } catch (e) {
      print('Error loading employee data: $e');
      _error = 'Failed to load employee data';
      notifyListeners();
    }
  }

  // Sign in with email and password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final userCredential = await FirebaseService.signInWithEmailAndPassword(email, password);
      
      if (userCredential != null) {
        _currentUser = userCredential.user;
        if (_currentUser != null) {
          await _loadEmployeeData(_currentUser!.uid);
        }
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Invalid email or password';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = _getErrorMessage(e);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Sign up with email and password
  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final userCredential = await FirebaseService.createUserWithEmailAndPassword(email, password);
      
      if (userCredential != null) {
        _currentUser = userCredential.user;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Failed to create account';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = _getErrorMessage(e);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      _isLoading = true;
      notifyListeners();

      await FirebaseService.signOut();
      
      _currentUser = null;
      _currentEmployee = null;
      _error = null;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to sign out';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update employee profile
  Future<bool> updateEmployeeProfile(Employee employee) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await FirebaseService.updateEmployee(employee);
      
      if (_currentEmployee?.employeeId == employee.employeeId) {
        _currentEmployee = employee;
      }
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to update profile';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Get error message from Firebase Auth exception
  String _getErrorMessage(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'No user found with this email address.';
        case 'wrong-password':
          return 'Wrong password provided.';
        case 'email-already-in-use':
          return 'An account already exists with this email address.';
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'user-disabled':
          return 'This user account has been disabled.';
        case 'too-many-requests':
          return 'Too many requests. Please try again later.';
        case 'operation-not-allowed':
          return 'This operation is not allowed.';
        default:
          return 'Authentication failed. Please try again.';
      }
    }
    return 'An error occurred. Please try again.';
  }

  // Check if user has specific role or permission
  bool hasRole(String role) {
    // This can be extended to check user roles from Firestore
    return _currentEmployee != null;
  }

  // Check if user is manager
  bool get isManager {
    return _currentEmployee?.position.toLowerCase().contains('manager') ?? false;
  }

  // Check if user is admin
  bool get isAdmin {
    return _currentEmployee?.position.toLowerCase().contains('admin') ?? false;
  }

  // Get user's department
  String? get userDepartment {
    return _currentEmployee?.department;
  }

  // Get user's employee ID
  String? get userEmployeeId {
    return _currentEmployee?.employeeId;
  }

  // Get user's full name
  String get userFullName {
    return _currentEmployee?.fullName ?? _currentUser?.displayName ?? 'Unknown User';
  }

  // Get user's email
  String get userEmail {
    return _currentUser?.email ?? '';
  }

  // Check if user profile is complete
  bool get isProfileComplete {
    return _currentEmployee != null;
  }
} 