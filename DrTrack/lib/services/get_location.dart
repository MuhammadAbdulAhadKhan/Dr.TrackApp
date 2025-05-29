import 'package:geolocator/geolocator.dart';

Future<String> getCurrentLocationUrl() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return 'Location not available';
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.deniedForever) {
    return 'Location permission denied';
  }

  Position pos = await Geolocator.getCurrentPosition();
  return 'https://maps.google.com/?q=${pos.latitude},${pos.longitude}';
}
