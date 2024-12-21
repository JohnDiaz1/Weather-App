
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final locationProvider = StateProvider<LocationProvider>((ref) {
  return LocationProvider();
});

final userLocationProvider = FutureProvider<Position>((ref) async {
  final locationProvider = LocationProvider();
  return await locationProvider.getUserCurrentLocation();
});

class LocationProvider {

  getUserCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled) {
      //TODO: Add a error and open settings
    }

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        //TODO: Add a error and open settings
      }
    }

    if(permission == LocationPermission.deniedForever) {
      //TODO: Add a error and open settings
    }
    return await Geolocator.getCurrentPosition();
  }

}