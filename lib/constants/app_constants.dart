import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  // App Information
  static const String appName = 'Worklytics';
  static const String appVersion = '1.0.0';
  
  // Colors
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color primaryDarkColor = Color(0xFF1976D2);
  static const Color primaryLightColor = Color(0xFFBBDEFB);
  static const Color accentColor = Color(0xFFFF9800);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFF44336);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color infoColor = Color(0xFF2196F3);
  
  // Background Colors
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  
  // Text Colors
  static const Color textPrimaryColor = Color(0xFF212121);
  static const Color textSecondaryColor = Color(0xFF757575);
  static const Color textHintColor = Color(0xFFBDBDBD);
  
  // Attendance Status Colors
  static const Color presentColor = Color(0xFF4CAF50);
  static const Color absentColor = Color(0xFFF44336);
  static const Color halfDayColor = Color(0xFFFF9800);
  static const Color leaveColor = Color(0xFF9C27B0);
  
  // Session Type Colors
  static const Color workColor = Color(0xFF2196F3);
  static const Color breakColor = Color(0xFFFF9800);
  static const Color lunchColor = Color(0xFF4CAF50);
  static const Color meetingColor = Color(0xFF9C27B0);
  
  // Spacing
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;
  
  // Border Radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusXXL = 24.0;
  
  // Icon Sizes
  static const double iconSizeS = 16.0;
  static const double iconSizeM = 24.0;
  static const double iconSizeL = 32.0;
  static const double iconSizeXL = 48.0;
  
  // Button Heights
  static const double buttonHeightS = 36.0;
  static const double buttonHeightM = 48.0;
  static const double buttonHeightL = 56.0;
  
  // Animation Durations
  static const Duration animationDurationFast = Duration(milliseconds: 200);
  static const Duration animationDurationNormal = Duration(milliseconds: 300);
  static const Duration animationDurationSlow = Duration(milliseconds: 500);
  
  // Default Working Hours
  static const int defaultWorkingHours = 8;
  static const int defaultGraceMinutes = 15;
  static const int defaultMaxBreakMinutes = 90;
  static const int defaultMaxBreakSessions = 3;
  
  // Geofencing
  static const int defaultGeofenceRadius = 100; // meters
  static const bool defaultGeofencingEnabled = true;
  
  // Notifications
  static const bool defaultReminderEnabled = true;
  static const int defaultReminderMinutes = 30;
  
  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String displayTimeFormat = 'hh:mm a';
  
  // Validation
  static const int minPasswordLength = 6;
  static const int maxNameLength = 50;
  static const int maxEmailLength = 100;
  static const int maxPhoneLength = 20;
  static const int maxNotesLength = 500;
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Cache
  static const Duration cacheDuration = Duration(minutes: 5);
  static const Duration longCacheDuration = Duration(hours: 1);
  
  // Error Messages
  static const String errorNetworkConnection = 'No internet connection. Please check your network.';
  static const String errorServerConnection = 'Unable to connect to server. Please try again.';
  static const String errorUnknown = 'An unknown error occurred. Please try again.';
  static const String errorInvalidCredentials = 'Invalid email or password.';
  static const String errorEmailAlreadyInUse = 'Email is already registered.';
  static const String errorWeakPassword = 'Password is too weak.';
  static const String errorLocationPermission = 'Location permission is required for attendance tracking.';
  static const String errorLocationDisabled = 'Location services are disabled. Please enable them.';
  
  // Success Messages
  static const String successClockIn = 'Successfully clocked in!';
  static const String successClockOut = 'Successfully clocked out!';
  static const String successBreakStart = 'Break started successfully!';
  static const String successBreakEnd = 'Break ended successfully!';
  static const String successProfileUpdate = 'Profile updated successfully!';
  static const String successPasswordChange = 'Password changed successfully!';
  
  // Info Messages
  static const String infoAlreadyClockedIn = 'You are already clocked in for today.';
  static const String infoNoActiveSession = 'No active session found.';
  static const String infoAlreadyOnBreak = 'You are already on break.';
  static const String infoNoActiveBreak = 'No active break session found.';
  static const String infoLocationRequired = 'Location is required for attendance tracking.';
  
  // Placeholder Text
  static const String placeholderEmail = 'Enter your email';
  static const String placeholderPassword = 'Enter your password';
  static const String placeholderFirstName = 'Enter first name';
  static const String placeholderLastName = 'Enter last name';
  static const String placeholderPhone = 'Enter phone number';
  static const String placeholderDepartment = 'Select department';
  static const String placeholderPosition = 'Enter position';
  static const String placeholderNotes = 'Enter notes (optional)';
  
  // Button Text
  static const String buttonLogin = 'Login';
  static const String buttonSignUp = 'Sign Up';
  static const String buttonLogout = 'Logout';
  static const String buttonClockIn = 'Clock In';
  static const String buttonClockOut = 'Clock Out';
  static const String buttonStartBreak = 'Start Break';
  static const String buttonEndBreak = 'End Break';
  static const String buttonSave = 'Save';
  static const String buttonCancel = 'Cancel';
  static const String buttonEdit = 'Edit';
  static const String buttonDelete = 'Delete';
  static const String buttonAdd = 'Add';
  static const String buttonUpdate = 'Update';
  static const String buttonSubmit = 'Submit';
  static const String buttonRetry = 'Retry';
  static const String buttonRefresh = 'Refresh';
  static const String buttonNext = 'Next';
  static const String buttonPrevious = 'Previous';
  static const String buttonDone = 'Done';
  static const String buttonSkip = 'Skip';
  
  // Navigation Labels
  static const String navDashboard = 'Dashboard';
  static const String navAttendance = 'Attendance';
  static const String navProfile = 'Profile';
  static const String navReports = 'Reports';
  static const String navSettings = 'Settings';
  static const String navEmployees = 'Employees';
  static const String navDepartments = 'Departments';
  
  // Screen Titles
  static const String titleLogin = 'Login';
  static const String titleSignUp = 'Sign Up';
  static const String titleDashboard = 'Dashboard';
  static const String titleAttendance = 'Attendance';
  static const String titleProfile = 'Profile';
  static const String titleReports = 'Reports';
  static const String titleSettings = 'Settings';
  static const String titleEmployees = 'Employees';
  static const String titleDepartments = 'Departments';
  static const String titleAddEmployee = 'Add Employee';
  static const String titleEditEmployee = 'Edit Employee';
  static const String titleAddDepartment = 'Add Department';
  static const String titleEditDepartment = 'Edit Department';
  
  // Tab Labels
  static const String tabToday = 'Today';
  static const String tabWeek = 'Week';
  static const String tabMonth = 'Month';
  static const String tabYear = 'Year';
  static const String tabOverview = 'Overview';
  static const String tabDetails = 'Details';
  static const String tabAnalytics = 'Analytics';
  
  // Status Labels
  static const String statusPresent = 'Present';
  static const String statusAbsent = 'Absent';
  static const String statusHalfDay = 'Half Day';
  static const String statusLeave = 'Leave';
  static const String statusLate = 'Late';
  static const String statusEarlyOut = 'Early Out';
  static const String statusOnTime = 'On Time';
  static const String statusOvertime = 'Overtime';
  
  // Session Type Labels
  static const String sessionWork = 'Work';
  static const String sessionBreak = 'Break';
  static const String sessionLunch = 'Lunch';
  static const String sessionMeeting = 'Meeting';
  
  // Clock Method Labels
  static const String methodManual = 'Manual';
  static const String methodBiometric = 'Biometric';
  static const String methodQRCode = 'QR Code';
  
  // Time Labels
  static const String timeClockIn = 'Clock In';
  static const String timeClockOut = 'Clock Out';
  static const String timeBreakStart = 'Break Start';
  static const String timeBreakEnd = 'Break End';
  static const String timeTotalWork = 'Total Work';
  static const String timeTotalBreak = 'Total Break';
  static const String timeOvertime = 'Overtime';
  
  // Chart Labels
  static const String chartAttendance = 'Attendance';
  static const String chartWorkHours = 'Work Hours';
  static const String chartBreakHours = 'Break Hours';
  static const String chartOvertime = 'Overtime';
  static const String chartLateArrivals = 'Late Arrivals';
  static const String chartEarlyDepartures = 'Early Departures';
  
  // Report Labels
  static const String reportDaily = 'Daily Report';
  static const String reportWeekly = 'Weekly Report';
  static const String reportMonthly = 'Monthly Report';
  static const String reportYearly = 'Yearly Report';
  static const String reportEmployee = 'Employee Report';
  static const String reportDepartment = 'Department Report';
  static const String reportAttendance = 'Attendance Report';
  static const String reportOvertime = 'Overtime Report';
  
  // Settings Labels
  static const String settingWorkingHours = 'Working Hours';
  static const String settingBreakRules = 'Break Rules';
  static const String settingGeofencing = 'Geofencing';
  static const String settingNotifications = 'Notifications';
  static const String settingPrivacy = 'Privacy';
  static const String settingSecurity = 'Security';
  static const String settingAbout = 'About';
  static const String settingHelp = 'Help';
  static const String settingFeedback = 'Feedback';
  
  // Permission Messages
  static const String permissionLocationTitle = 'Location Permission';
  static const String permissionLocationMessage = 'This app needs location access to track your attendance accurately.';
  static const String permissionCameraTitle = 'Camera Permission';
  static const String permissionCameraMessage = 'This app needs camera access to scan QR codes for attendance.';
  static const String permissionNotificationTitle = 'Notification Permission';
  static const String permissionNotificationMessage = 'This app needs notification access to send you attendance reminders.';
  
  // Loading Messages
  static const String loadingClockIn = 'Clocking in...';
  static const String loadingClockOut = 'Clocking out...';
  static const String loadingBreakStart = 'Starting break...';
  static const String loadingBreakEnd = 'Ending break...';
  static const String loadingSaving = 'Saving...';
  static const String loadingUpdating = 'Updating...';
  static const String loadingDeleting = 'Deleting...';
  static const String loadingRefreshing = 'Refreshing...';
  static const String loadingSyncing = 'Syncing...';
  
  // Empty State Messages
  static const String emptyNoAttendance = 'No attendance records found.';
  static const String emptyNoEmployees = 'No employees found.';
  static const String emptyNoDepartments = 'No departments found.';
  static const String emptyNoReports = 'No reports available.';
  static const String emptyNoSessions = 'No sessions found for this date.';
  static const String emptyNoData = 'No data available.';
  
  // Confirmation Messages
  static const String confirmLogout = 'Are you sure you want to logout?';
  static const String confirmDelete = 'Are you sure you want to delete this item?';
  static const String confirmClockOut = 'Are you sure you want to clock out?';
  static const String confirmEndBreak = 'Are you sure you want to end your break?';
  static const String confirmDiscardChanges = 'Are you sure you want to discard your changes?';
  
  // Tooltip Messages
  static const String tooltipClockIn = 'Clock in to start your work day';
  static const String tooltipClockOut = 'Clock out to end your work day';
  static const String tooltipBreak = 'Take a break from work';
  static const String tooltipRefresh = 'Refresh the data';
  static const String tooltipEdit = 'Edit this item';
  static const String tooltipDelete = 'Delete this item';
  static const String tooltipSettings = 'Open settings';
  static const String tooltipHelp = 'Get help';
  static const String tooltipProfile = 'View your profile';
  static const String tooltipLogout = 'Logout from the app';
  
  // Accessibility Labels
  static const String accessibilityClockInButton = 'Clock in button';
  static const String accessibilityClockOutButton = 'Clock out button';
  static const String accessibilityBreakButton = 'Break button';
  static const String accessibilityRefreshButton = 'Refresh button';
  static const String accessibilityEditButton = 'Edit button';
  static const String accessibilityDeleteButton = 'Delete button';
  static const String accessibilitySettingsButton = 'Settings button';
  static const String accessibilityProfileButton = 'Profile button';
  static const String accessibilityLogoutButton = 'Logout button';
  static const String accessibilityMenuButton = 'Menu button';
  static const String accessibilityBackButton = 'Back button';
  static const String accessibilityCloseButton = 'Close button';
  static const String accessibilitySaveButton = 'Save button';
  static const String accessibilityCancelButton = 'Cancel button';
  static const String accessibilityAddButton = 'Add button';
  static const String accessibilityUpdateButton = 'Update button';
  static const String accessibilitySubmitButton = 'Submit button';
  static const String accessibilityRetryButton = 'Retry button';
  static const String accessibilityNextButton = 'Next button';
  static const String accessibilityPreviousButton = 'Previous button';
  static const String accessibilityDoneButton = 'Done button';
  static const String accessibilitySkipButton = 'Skip button';
  
  // Text Styles
  static TextStyle get heading1 => GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textPrimaryColor,
  );
  
  static TextStyle get heading2 => GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textPrimaryColor,
  );
  
  static TextStyle get heading3 => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );
  
  static TextStyle get heading4 => GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );
  
  static TextStyle get heading5 => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );
  
  static TextStyle get heading6 => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );
  
  static TextStyle get body1 => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textPrimaryColor,
  );
  
  static TextStyle get body2 => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: textPrimaryColor,
  );
  
  static TextStyle get caption => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: textSecondaryColor,
  );
  
  static TextStyle get button => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  
  static TextStyle get overline => GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    color: textSecondaryColor,
    letterSpacing: 1.5,
  );
  
  static TextStyle get subtitle1 => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textSecondaryColor,
  );
  
  static TextStyle get subtitle2 => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: textSecondaryColor,
  );
} 