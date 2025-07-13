# Worklytics - Employee Management & Attendance Tracking App

A comprehensive Flutter application for employee management and attendance tracking with Firebase integration.

## 🚀 Features

### Core Features
- **Employee Management**: Complete employee profile management with departments and positions
- **Attendance Tracking**: Real-time clock in/out with location tracking
- **Break Management**: Track work breaks and lunch sessions
- **Geofencing**: Location-based attendance verification
- **Reports & Analytics**: Monthly and yearly attendance reports
- **Multi-platform**: Works on Android, iOS, and Web

### Technical Features
- **Firebase Integration**: Firestore database with real-time updates
- **Authentication**: Secure email/password authentication
- **Location Services**: GPS tracking with geofencing support
- **Offline Support**: Works offline with data synchronization
- **Modern UI**: Material Design 3 with custom theming
- **State Management**: Provider pattern for efficient state management

## 📱 Screenshots

*Screenshots will be added as the app development progresses*

## 🛠️ Tech Stack

- **Frontend**: Flutter 3.8+
- **Backend**: Firebase (Firestore, Authentication, Cloud Functions)
- **State Management**: Provider
- **Location Services**: Geolocator, Geocoding
- **UI Components**: Material Design 3, Google Fonts
- **Charts**: FL Chart
- **QR Code**: QR Flutter, QR Code Scanner

## 📋 Prerequisites

Before running this application, make sure you have:

- Flutter SDK (3.8.1 or higher)
- Dart SDK (3.8.1 or higher)
- Android Studio / VS Code
- Firebase project with Firestore enabled
- Google Services configuration files

## 🔧 Installation & Setup

### 1. Clone the Repository
```bash
git clone <repository-url>
cd worklytics
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Firebase Setup

#### Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or select existing project
3. Enable Authentication (Email/Password)
4. Create Firestore database
5. Set up security rules

#### Configure Firebase for Flutter
1. Install FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
```

2. Configure Firebase for your app:
```bash
flutterfire configure
```

3. Update `lib/firebase_options.dart` with your Firebase configuration

#### Firestore Security Rules
Add these security rules to your Firestore database:

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

### 4. Platform-specific Setup

#### Android
1. Add `google-services.json` to `android/app/`
2. Update `android/app/build.gradle.kts`:
```kotlin
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")
}
```

3. Update `android/build.gradle.kts`:
```kotlin
buildscript {
    dependencies {
        classpath("com.google.gms:google-services:4.4.0")
    }
}
```

#### iOS
1. Add `GoogleService-Info.plist` to iOS project
2. Update iOS deployment target to 12.0+

### 5. Run the Application
```bash
flutter run
```

## 📊 Database Structure

The app uses a hierarchical Firestore structure:

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

### Collections

#### employees/{employeeId}
Employee profile information including:
- Personal details (name, email, phone)
- Department and position
- Working hours configuration
- Joining date and status

#### employees/{employeeId}/attendance/{year}/{month}/{date}/sessions/{sessionId}
Individual attendance sessions:
- Clock in/out times
- Session type (work, break, lunch, meeting)
- Location data
- Duration and notes

#### departments/{departmentId}
Department information:
- Name and description
- Manager assignment
- Employee count

#### attendance_summary/{employeeId}_{year}_{month}
Monthly attendance summaries:
- Total working days
- Present/absent days
- Work hours and overtime
- Late arrivals and early departures

#### app_settings/attendance_rules
Application configuration:
- Working hours rules
- Break policies
- Geofencing settings
- Notification preferences

## 🎯 Usage

### For Employees
1. **Login**: Use your company email and password
2. **Clock In**: Tap "Clock In" when arriving at work
3. **Take Breaks**: Use "Start Break" and "End Break" for breaks
4. **Clock Out**: Tap "Clock Out" when leaving work
5. **View Reports**: Check your attendance history and statistics

### For Managers
1. **Employee Management**: Add, edit, and manage employee profiles
2. **Department Management**: Create and manage departments
3. **Reports**: View team attendance reports and analytics
4. **Settings**: Configure attendance rules and policies

## 🔐 Authentication

The app uses Firebase Authentication with email/password:
- Secure login/logout
- Password reset functionality
- Role-based access control
- Session management

## 📍 Location Services

- **GPS Tracking**: Automatic location capture for attendance
- **Geofencing**: Verify employee is at office location
- **Offline Support**: Location data cached when offline
- **Privacy**: Location data only used for attendance verification

## 📈 Reports & Analytics

### Available Reports
- **Daily Attendance**: Today's work hours and breaks
- **Weekly Summary**: Weekly attendance overview
- **Monthly Report**: Detailed monthly statistics
- **Yearly Analytics**: Annual attendance trends

### Metrics Tracked
- Total work hours
- Break duration
- Overtime hours
- Attendance percentage
- Late arrivals
- Early departures

## 🎨 UI/UX Features

- **Material Design 3**: Modern, accessible interface
- **Dark/Light Theme**: Automatic theme switching
- **Responsive Design**: Works on all screen sizes
- **Smooth Animations**: Engaging user experience
- **Accessibility**: Screen reader support

## 🚀 Deployment

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation

## 🔄 Version History

### v1.0.0 (Current)
- Initial release
- Basic employee management
- Attendance tracking
- Firebase integration
- Location services

### Planned Features
- [ ] Push notifications
- [ ] Advanced analytics
- [ ] Team management
- [ ] Leave management
- [ ] Payroll integration
- [ ] Mobile app (iOS/Android)
- [ ] Web dashboard
- [ ] API documentation

## 📞 Contact

- **Project Link**: [Repository URL]
- **Email**: [Contact Email]
- **Documentation**: [Documentation URL]

---

**Note**: This is a work in progress. Features are being added continuously. Please check the issues section for known bugs and planned features.
