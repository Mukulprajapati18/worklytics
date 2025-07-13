import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:permission_handler/permission_handler.dart';
import '../models/models.dart';

class LocationService {
  static LocationService? _instance;
  static LocationService get instance => _instance ??= LocationService._internal();
  
  LocationService._internal();

  // Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Check location permission
  Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  // Request location permission
  Future<LocationPermission> requestPermission() async {
    return await Geolocator.requestPermission();
  }

  // Request location permission using permission_handler
  Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  // Get current position
  Future<Position?> getCurrentPosition() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      // Check location permission
      LocationPermission permission = await checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied, we cannot request permissions.');
      }

      // Get current position
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
    } catch (e) {
      print('Error getting current position: $e');
      return null;
    }
  }

  // Get address from coordinates
  Future<String?> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        geocoding.Placemark place = placemarks[0];
        return '${place.street}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}';
      }
      return null;
    } catch (e) {
      print('Error getting address: $e');
      return null;
    }
  }

  // Calculate distance between two points
  double calculateDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
  }

  // Check if location is within geofence
  bool isWithinGeofence(Location currentLocation, Location officeLocation, int radiusInMeters) {
    double distance = calculateDistance(
      currentLocation.latitude,
      currentLocation.longitude,
      officeLocation.latitude,
      officeLocation.longitude,
    );
    return distance <= radiusInMeters;
  }

  // Get location with address
  Future<Location?> getLocationWithAddress() async {
    try {
      Position? position = await getCurrentPosition();
      if (position != null) {
        String? address = await getAddressFromCoordinates(position.latitude, position.longitude);
        return Location(
          latitude: position.latitude,
          longitude: position.longitude,
          address: address,
        );
      }
      return null;
    } catch (e) {
      print('Error getting location with address: $e');
      return null;
    }
  }

  // Stream location updates
  Stream<Position> getLocationStream() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Update every 10 meters
    );

    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  // Check if user is at office (within geofence)
  Future<bool> isAtOffice(Location officeLocation, int radiusInMeters) async {
    try {
      Position? currentPosition = await getCurrentPosition();
      if (currentPosition != null) {
        return isWithinGeofence(
          Location(
            latitude: currentPosition.latitude,
            longitude: currentPosition.longitude,
          ),
          officeLocation,
          radiusInMeters,
        );
      }
      return false;
    } catch (e) {
      print('Error checking if at office: $e');
      return false;
    }
  }

  // Get formatted distance
  String getFormattedDistance(double distanceInMeters) {
    if (distanceInMeters < 1000) {
      return '${distanceInMeters.round()}m';
    } else {
      double kilometers = distanceInMeters / 1000;
      return '${kilometers.toStringAsFixed(1)}km';
    }
  }

  // Get location accuracy description
  String getAccuracyDescription(LocationAccuracy accuracy) {
    switch (accuracy) {
      case LocationAccuracy.lowest:
        return 'Lowest';
      case LocationAccuracy.low:
        return 'Low';
      case LocationAccuracy.medium:
        return 'Medium';
      case LocationAccuracy.high:
        return 'High';
      case LocationAccuracy.best:
        return 'Best';
      case LocationAccuracy.bestForNavigation:
        return 'Best for Navigation';
      default:
        return 'Unknown';
    }
  }

  // Check if location permission is permanently denied
  Future<bool> isLocationPermissionPermanentlyDenied() async {
    LocationPermission permission = await checkPermission();
    return permission == LocationPermission.deniedForever;
  }

  // Open app settings
  Future<bool> openAppSettings() async {
    return await openAppSettings();
  }
} 