import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/config/constants/endpoints.dart';
import 'dart:async';

class WeatherServices {
  Future<http.Response> getDailyAggregation(
      {required Position userPosition, required String date}) async {
    try {
      final response = await http.get(
        Uri.parse(urlGetDailyAggregations).replace(queryParameters: {
          'lat': userPosition.latitude.toString(),
          'lon': userPosition.longitude.toString(),
          'date': date,
          'appid': apiKey!,
          'units': 'metric',
          'lang': 'es'
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Error to obtain daily aggregation: ${e.toString()}');
    }
  }

  Future<http.Response> getCurrentForecast({required Position userPosition}) async {
    try {
      final response = await http.get(
        Uri.parse(urlGetCurrentForecast).replace(queryParameters: {
          'lat': userPosition.latitude.toString(),
          'lon': userPosition.longitude.toString(),
          'appid': apiKey!,
          'units': 'metric',
          'lang': 'es'
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Error to obtain daily aggregation: ${e.toString()}');
    }
  }
}
