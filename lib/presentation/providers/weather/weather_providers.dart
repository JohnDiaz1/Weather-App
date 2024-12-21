import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:weather_app/domain/models/daily_aggregation_model.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

import '../../../domain/models/current_forecast_model.dart';
import '../services/location_provider.dart';



// Singleton de WeatherController
final weatherServiceProvider = Provider<WeatherController>((ref) => WeatherController());

// Provider de la ubicación compartida
final actualUserLocationProvider = FutureProvider<Position>((ref) async {
  final location = ref.read(locationProvider);
  return await location.getUserCurrentLocation();
});

// Provider del clima
final weatherProvider = FutureProvider<DailyAggregation>((ref) async {
  final service = ref.read(weatherServiceProvider);
  final userPosition = await ref.watch(userLocationProvider.future);

  return await service.getDailyAggregation(
    userPosition: userPosition,
    date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
  );
});

final currentForecastProvider = FutureProvider<CurrentForecast>((ref) async {
  final service = ref.read(weatherServiceProvider);
  final userPosition = await ref.watch(userLocationProvider.future);

  return await service.getCurrentForecast(
    userPosition: userPosition,
  );
});

//Provider de busqueda de nombre
final nameLocationProvider = FutureProvider<Place>((ref) async {
  final userPosition = await ref.watch(userLocationProvider.future);

  return await Nominatim.reverseSearch(
    lat: userPosition.latitude,
    lon: userPosition.longitude,
    addressDetails: true,
    extraTags: true,
    nameDetails: true,
  );
});
