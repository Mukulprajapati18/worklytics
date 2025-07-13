# Firebase Firestore Database Structure for Employee Attendance App

## Collection Structure Overview

```
firestore-database/
├── employees/
│   └── {employeeId}/
│       ├── profile data
│       └── attendance/
│           └── {year}/
│               └── {month}/
│                   └── {date}/
│                       └── sessions/
│                           └── {sessionId}
├── departments/
├── attendance_summary/
└── app_settings/
```

## Detailed Collection Structures

### 1. employees/{employeeId}
```json
{
  "employeeId": "EMP001",
  "firstName": "John",
  "lastName": "Doe",
  "email": "john.doe@company.com",
  "department": "Engineering",
  "position": "Software Developer",
  "phoneNumber": "+1234567890",
  "isActive": true,
  "joiningDate": "2024-01-15T00:00:00Z",
  "workingHours": {
    "standardHours": 8,
    "flexibleTiming": true,
    "coreHours": {
      "start": "10:00",
      "end": "16:00"
    }
  },
  "createdAt": "2024-01-15T09:00:00Z",
  "updatedAt": "2024-01-15T09:00:00Z"
}
```

### 2. employees/{employeeId}/attendance/{year}/{month}/{date}/sessions/{sessionId}
```json
{
  "sessionId": "session_20240715_001",
  "employeeId": "EMP001",
  "date": "2024-07-15",
  "clockIn": "2024-07-15T09:00:00Z",
  "clockOut": "2024-07-15T18:00:00Z",
  "sessionType": "work", // "work", "break", "lunch", "meeting"
  "duration": 480, // in minutes
  "location": {
    "latitude": 40.7128,
    "longitude": -74.0060,
    "address": "Office Address"
  },
  "clockInMethod": "manual", // "manual", "biometric", "qr_code"
  "clockOutMethod": "manual",
  "isActive": false, // true if session is ongoing
  "notes": "Regular work session",
  "createdAt": "2024-07-15T09:00:00Z",
  "updatedAt": "2024-07-15T18:00:00Z"
}
```

### 3. employees/{employeeId}/attendance/{year}/{month}/{date}
```json
{
  "date": "2024-07-15",
  "employeeId": "EMP001",
  "totalWorkMinutes": 480,
  "totalBreakMinutes": 60,
  "totalSessions": 6,
  "firstClockIn": "2024-07-15T09:00:00Z",
  "lastClockOut": "2024-07-15T18:00:00Z",
  "isPresent": true,
  "isLate": false,
  "isEarlyOut": false,
  "status": "present", // "present", "absent", "half_day", "leave"
  "sessionIds": ["session_20240715_001", "session_20240715_002"],
  "createdAt": "2024-07-15T09:00:00Z",
  "updatedAt": "2024-07-15T18:00:00Z"
}
```

### 4. attendance_summary/{employeeId}_{year}_{month}
```json
{
  "employeeId": "EMP001",
  "year": 2024,
  "month": 7,
  "totalWorkingDays": 22,
  "presentDays": 20,
  "absentDays": 2,
  "lateArrivals": 3,
  "earlyDepartures": 1,
  "totalWorkHours": 160,
  "totalBreakHours": 20,
  "overtimeHours": 5,
  "averageWorkHours": 8.0,
  "createdAt": "2024-07-01T00:00:00Z",
  "updatedAt": "2024-07-15T18:00:00Z"
}
```

### 5. departments/{departmentId}
```json
{
  "departmentId": "DEPT001",
  "name": "Engineering",
  "description": "Software Development Department",
  "managerId": "EMP001",
  "employeeCount": 25,
  "isActive": true,
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-01-01T00:00:00Z"
}
```

### 6. app_settings/attendance_rules
```json
{
  "workingHours": {
    "standardHours": 8,
    "maxOvertimeHours": 4,
    "graceMinutes": 15
  },
  "breakRules": {
    "maxBreakSessions": 3,
    "maxBreakMinutes": 90
  },
  "geofencing": {
    "enabled": true,
    "radius": 100
  },
  "notifications": {
    "reminderEnabled": true,
    "reminderTime": 30
  }
}
```

## Security Rules Example

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Employees can read their own data
    match /employees/{employeeId} {
      allow read, write: if request.auth != null && 
        request.auth.uid == resource.data.authId;
    }
    
    // Employees can manage their own attendance
    match /employees/{employeeId}/attendance/{year}/{month}/{date}/{document=**} {
      allow read, write: if request.auth != null && 
        request.auth.uid == resource.data.employeeId;
    }
    
    // Managers can read department employee data
    match /employees/{employeeId} {
      allow read: if request.auth != null && 
        exists(/databases/$(database)/documents/departments/$(resource.data.department)) &&
        get(/databases/$(database)/documents/departments/$(resource.data.department)).data.managerId == request.auth.uid;
    }
  }
}
```

## Indexing Strategy

### Composite Indexes
1. **Employee Attendance Query**: `employeeId` + `date` (ascending)
2. **Department Queries**: `department` + `isActive` (ascending)
3. **Date Range Queries**: `employeeId` + `date` (ascending) + `clockIn` (ascending)
4. **Session Type Queries**: `employeeId` + `sessionType` + `date` (ascending)

### Single Field Indexes
- `employeeId` (ascending)
- `date` (ascending)
- `isActive` (ascending)
- `sessionType` (ascending)

## Key Benefits of This Structure

1. **Scalability**: Hierarchical structure prevents deep nesting and allows efficient queries
2. **Performance**: Date-based partitioning improves query performance
3. **Flexibility**: Supports multiple session types (work, break, lunch)
4. **Real-time Updates**: Structure supports live attendance tracking
5. **Reporting**: Easy aggregation for monthly/yearly reports
6. **Security**: Granular access control for employee data
7. **Offline Support**: Structure works well with Flutter's offline capabilities

## Query Examples

### Get Today's Attendance for an Employee
```dart
FirebaseFirestore.instance
  .collection('employees')
  .doc(employeeId)
  .collection('attendance')
  .doc(year.toString())
  .collection(month.toString())
  .doc(date.toString())
  .get()
```

### Get Active Session for an Employee
```dart
FirebaseFirestore.instance
  .collection('employees')
  .doc(employeeId)
  .collection('attendance')
  .doc(year.toString())
  .collection(month.toString())
  .doc(date.toString())
  .collection('sessions')
  .where('isActive', isEqualTo: true)
  .limit(1)
  .get()
```

### Get Monthly Summary
```dart
FirebaseFirestore.instance
  .collection('attendance_summary')
  .doc('${employeeId}_${year}_${month}')
  .get()
```

This structure provides a solid foundation for your attendance app that can scale to handle thousands of employees while maintaining good performance and security.