import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../services/firebase_service.dart';

final employeeProvider = ChangeNotifierProvider<EmployeeProvider>((ref) => EmployeeProvider());

class EmployeeProvider extends ChangeNotifier {
  List<Employee> _employees = [];
  List<Department> _departments = [];
  Employee? _selectedEmployee;
  Department? _selectedDepartment;
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Employee> get employees => _employees;
  List<Department> get departments => _departments;
  Employee? get selectedEmployee => _selectedEmployee;
  Department? get selectedDepartment => _selectedDepartment;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Load all employees
  Future<void> loadEmployees() async {
    try {
      _isLoading = true;
      notifyListeners();

      _employees = await FirebaseService.getAllEmployees();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load employees';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load employees by department
  Future<void> loadEmployeesByDepartment(String department) async {
    try {
      _isLoading = true;
      notifyListeners();

      _employees = await FirebaseService.getEmployeesByDepartment(department);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load employees by department';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load all departments
  Future<void> loadDepartments() async {
    try {
      _isLoading = true;
      notifyListeners();

      _departments = await FirebaseService.getAllDepartments();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load departments';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get employee by ID
  Future<Employee?> getEmployee(String employeeId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final employee = await FirebaseService.getEmployee(employeeId);
      
      _isLoading = false;
      notifyListeners();
      return employee;
    } catch (e) {
      _error = 'Failed to get employee';
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  // Get department by ID
  Future<Department?> getDepartment(String departmentId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final department = await FirebaseService.getDepartment(departmentId);
      
      _isLoading = false;
      notifyListeners();
      return department;
    } catch (e) {
      _error = 'Failed to get department';
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  // Create new employee
  Future<bool> createEmployee(Employee employee) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await FirebaseService.createEmployee(employee);
      
      // Refresh employees list
      await loadEmployees();
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to create employee';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update employee
  Future<bool> updateEmployee(Employee employee) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await FirebaseService.updateEmployee(employee);
      
      // Update in local list
      final index = _employees.indexWhere((e) => e.employeeId == employee.employeeId);
      if (index != -1) {
        _employees[index] = employee;
      }
      
      // Update selected employee if it's the same
      if (_selectedEmployee?.employeeId == employee.employeeId) {
        _selectedEmployee = employee;
      }
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to update employee';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Delete employee (soft delete)
  Future<bool> deleteEmployee(String employeeId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await FirebaseService.deleteEmployee(employeeId);
      
      // Remove from local list
      _employees.removeWhere((e) => e.employeeId == employeeId);
      
      // Clear selected employee if it's the same
      if (_selectedEmployee?.employeeId == employeeId) {
        _selectedEmployee = null;
      }
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to delete employee';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Create new department
  Future<bool> createDepartment(Department department) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await FirebaseService.createDepartment(department);
      
      // Refresh departments list
      await loadDepartments();
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to create department';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update department
  Future<bool> updateDepartment(Department department) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await FirebaseService.updateDepartment(department);
      
      // Update in local list
      final index = _departments.indexWhere((d) => d.departmentId == department.departmentId);
      if (index != -1) {
        _departments[index] = department;
      }
      
      // Update selected department if it's the same
      if (_selectedDepartment?.departmentId == department.departmentId) {
        _selectedDepartment = department;
      }
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to update department';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Set selected employee
  void setSelectedEmployee(Employee? employee) {
    _selectedEmployee = employee;
    notifyListeners();
  }

  // Set selected department
  void setSelectedDepartment(Department? department) {
    _selectedDepartment = department;
    notifyListeners();
  }

  // Search employees by name
  List<Employee> searchEmployeesByName(String query) {
    if (query.isEmpty) return _employees;
    
    return _employees.where((employee) {
      final fullName = employee.fullName.toLowerCase();
      final searchQuery = query.toLowerCase();
      return fullName.contains(searchQuery);
    }).toList();
  }

  // Search employees by department
  List<Employee> searchEmployeesByDepartment(String department) {
    return _employees.where((employee) {
      return employee.department.toLowerCase() == department.toLowerCase();
    }).toList();
  }

  // Get employees count by department
  int getEmployeeCountByDepartment(String department) {
    return _employees.where((employee) {
      return employee.department.toLowerCase() == department.toLowerCase();
    }).length;
  }

  // Get active employees count
  int get activeEmployeesCount {
    return _employees.where((employee) => employee.isActive).length;
  }

  // Get inactive employees count
  int get inactiveEmployeesCount {
    return _employees.where((employee) => !employee.isActive).length;
  }

  // Get employees by position
  List<Employee> getEmployeesByPosition(String position) {
    return _employees.where((employee) {
      return employee.position.toLowerCase().contains(position.toLowerCase());
    }).toList();
  }

  // Get managers
  List<Employee> get managers {
    return _employees.where((employee) {
      return employee.position.toLowerCase().contains('manager');
    }).toList();
  }

  // Get employees hired in specific year
  List<Employee> getEmployeesByHireYear(int year) {
    return _employees.where((employee) {
      return employee.joiningDate.year == year;
    }).toList();
  }

  // Get employees by working hours
  List<Employee> getEmployeesByWorkingHours(int hours) {
    return _employees.where((employee) {
      return employee.workingHours.standardHours == hours;
    }).toList();
  }

  // Get department names
  List<String> get departmentNames {
    return _departments.map((dept) => dept.name).toList();
  }

  // Get position names
  List<String> get positionNames {
    final positions = <String>{};
    for (final employee in _employees) {
      positions.add(employee.position);
    }
    return positions.toList()..sort();
  }

  // Get employees with flexible timing
  List<Employee> get employeesWithFlexibleTiming {
    return _employees.where((employee) => employee.workingHours.flexibleTiming).toList();
  }

  // Get employees with standard timing
  List<Employee> get employeesWithStandardTiming {
    return _employees.where((employee) => !employee.workingHours.flexibleTiming).toList();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Refresh all data
  Future<void> refreshData() async {
    await Future.wait([
      loadEmployees(),
      loadDepartments(),
    ]);
  }

  // Get employee statistics
  Map<String, dynamic> get employeeStatistics {
    final totalEmployees = _employees.length;
    final activeEmployees = activeEmployeesCount;
    final inactiveEmployees = inactiveEmployeesCount;
    
    // Department distribution
    final departmentDistribution = <String, int>{};
    for (final employee in _employees) {
      departmentDistribution[employee.department] = 
          (departmentDistribution[employee.department] ?? 0) + 1;
    }
    
    // Position distribution
    final positionDistribution = <String, int>{};
    for (final employee in _employees) {
      positionDistribution[employee.position] = 
          (positionDistribution[employee.position] ?? 0) + 1;
    }
    
    // Hire year distribution
    final hireYearDistribution = <int, int>{};
    for (final employee in _employees) {
      final year = employee.joiningDate.year;
      hireYearDistribution[year] = (hireYearDistribution[year] ?? 0) + 1;
    }
    
    return {
      'totalEmployees': totalEmployees,
      'activeEmployees': activeEmployees,
      'inactiveEmployees': inactiveEmployees,
      'departmentDistribution': departmentDistribution,
      'positionDistribution': positionDistribution,
      'hireYearDistribution': hireYearDistribution,
    };
  }
} 