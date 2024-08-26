import 'package:geolocator/geolocator.dart';

class LocationServiceHelper {
  static Future<bool> checkLocationService() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  static Future<bool> openLocationSettings() async {
    await Geolocator.openLocationSettings();

    return await Geolocator.isLocationServiceEnabled();
  }

  Future<Position> checkAndRequestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled. Please enable them in your device settings.');
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied. Please grant location permissions in your device settings.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    return await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
  }

  // Get Current Location
  Future<Position?> getCurrentLocation() async {
    try {
      final serviceEnabled = await checkLocationService();

      if (!serviceEnabled) return null;
      return await checkAndRequestLocationPermission();
    } catch (e) {
      return null;
    }
  }
}
