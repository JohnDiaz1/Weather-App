import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/weather_services.dart';
import '../domain/models/current_forecast_model.dart';
import '../domain/models/daily_aggregation_model.dart';

class WeatherController {
  final WeatherServices _services;

  // Constructor que acepta una instancia de WeatherServices
  WeatherController({WeatherServices? weatherServices})
      : _services = weatherServices ?? WeatherServices();

  Future<DailyAggregation> getDailyAggregation({
    required Position userPosition,
    required String date
  }) async {
    try {
      final response = await _services.getDailyAggregation(
          userPosition: userPosition,
          date: date
      );

      if (response.statusCode == 200) {
        return dailyAggregationFromJson(response.body);
      } else {
        throw Exception('Failed to load daily aggregation: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching daily aggregation: $e');
    }
  }

  Future<CurrentForecast> getCurrentForecast({
    required Position userPosition
  }) async {
    try {
      final response = await _services.getCurrentForecast(
          userPosition: userPosition
      );

      if (response.statusCode == 200) {
        return currentForecastFromJson(response.body);
      } else {
        throw Exception('Failed to load current forecast: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching current forecast: $e');
    }
  }
}