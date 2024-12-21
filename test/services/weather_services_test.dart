import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/config/constants/endpoints.dart';
import 'package:weather_app/services/weather_services.dart';

class MockHttpClient extends Mock implements http.Client {}
class MockWeatherServices extends Mock implements WeatherServices {}

void main() {
  setUpAll(() async {
    await dotenv.load(fileName: 'test/.env.test');
  });

  // Declaramos las variables que usaremos en las pruebas
  late MockWeatherServices mockWeatherServices;
  late MockHttpClient mockHttp;

  // Datos de prueba
  final mockPosition = Position(
    latitude: 40.7128,
    longitude: -74.0060,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    altitudeAccuracy: 0.0,
    headingAccuracy: 0.0,
  );

  const testDate = '2024-03-20';

  setUp(() {
    mockHttp = MockHttpClient();
    mockWeatherServices = MockWeatherServices();
  });

  ///////////////////////////////////////////////////////////////////////////

  group('Test WeatherServices - getDailyAggregation', () {
    test('Test getDailyAggregation - success', () async {
      // Creamos la respuesta mockeada con datos realistas
      final mockResponseData = {
        "lat": 40.7128,
        "lon": -74.006,
        "timezone": "America/New_York",
        "current": {
          "temp": 20.5,
          "weather": [{"main": "Clear", "description": "clear sky"}]
        }
      };

      final httpResponse = http.Response(
          jsonEncode(mockResponseData),
          200
      );

      // Configuramos el comportamiento del mock para el caso exitoso
      when(() => mockWeatherServices.getDailyAggregation(
          userPosition: mockPosition,
          date: testDate
      )).thenAnswer((_) async => httpResponse);

      // Simulamos la respuesta HTTP
      when(() => mockHttp.get(
        Uri.parse(urlGetDailyAggregations),
        headers: any(named: 'headers'),
      )).thenAnswer((_) async => httpResponse);

      // Llamamos a la función y verificamos el resultado
      final response = await mockWeatherServices.getDailyAggregation(
          userPosition: mockPosition,
          date: testDate
      );

      expect(response.statusCode, 200);
      expect(
          jsonDecode(response.body),
          mockResponseData
      );
      verify(() => mockWeatherServices.getDailyAggregation(
          userPosition: mockPosition,
          date: testDate
      )).called(1);
    });

    test('Test getDailyAggregation - error', () async {
      final mockErrorResponse = {
        'error': 'Failed to fetch weather data',
        'code': 'WEATHER_FETCH_ERROR'
      };

      final httpResponse = http.Response(
          jsonEncode(mockErrorResponse),
          404
      );

      when(() => mockWeatherServices.getDailyAggregation(
          userPosition: mockPosition,
          date: testDate
      )).thenAnswer((_) async => httpResponse);

      when(() => mockHttp.get(
        Uri.parse(urlGetDailyAggregations),
        headers: any(named: 'headers'),
      )).thenAnswer((_) async => httpResponse);

      final response = await mockWeatherServices.getDailyAggregation(
          userPosition: mockPosition,
          date: testDate
      );

      expect(response.statusCode, 404);
      expect(
          jsonDecode(response.body),
          mockErrorResponse
      );
      verify(() => mockWeatherServices.getDailyAggregation(
          userPosition: mockPosition,
          date: testDate
      )).called(1);
    });
  });

  ////////////////////////////////////////////////////////////////////////

  group('Test WeatherServices - getCurrentForecast', () {
    test('Test getCurrentForecast - success', () async {
      // Creamos la respuesta mockeada con datos realistas
      final mockResponseData = {
        "current": {
          "temp": 22.8,
          "weather": [{"main": "Clouds", "description": "scattered clouds"}],
          "wind_speed": 12.5
        }
      };

      final httpResponse = http.Response(
          jsonEncode(mockResponseData),
          200
      );

      // Configuramos el comportamiento del mock
      when(() => mockWeatherServices.getCurrentForecast(
        userPosition: mockPosition,
      )).thenAnswer((_) async => httpResponse);

      // Simulamos la respuesta HTTP
      when(() => mockHttp.get(
        Uri.parse(urlGetCurrentForecast),
        headers: any(named: 'headers'),
      )).thenAnswer((_) async => httpResponse);

      // Llamamos a la función y verificamos el resultado
      final response = await mockWeatherServices.getCurrentForecast(
        userPosition: mockPosition,
      );

      // Verificaciones
      expect(response.statusCode, 200);
      expect(
          jsonDecode(response.body),
          mockResponseData
      );
      verify(() => mockWeatherServices.getCurrentForecast(
        userPosition: mockPosition,
      )).called(1);
    });

    test('Test getCurrentForecast - error', () async {
      // Creamos la respuesta mockeada para el caso de error
      final mockErrorResponse = {
        'error': 'Failed to fetch current forecast',
        'code': 'FORECAST_FETCH_ERROR'
      };

      final httpResponse = http.Response(
          jsonEncode(mockErrorResponse),
          404
      );

      when(() => mockWeatherServices.getCurrentForecast(
        userPosition: mockPosition,
      )).thenAnswer((_) async => httpResponse);

      when(() => mockHttp.get(
        Uri.parse(urlGetCurrentForecast),
        headers: any(named: 'headers'),
      )).thenAnswer((_) async => httpResponse);

      final response = await mockWeatherServices.getCurrentForecast(
        userPosition: mockPosition,
      );

      expect(response.statusCode, 404);
      expect(
          jsonDecode(response.body),
          mockErrorResponse
      );
      verify(() => mockWeatherServices.getCurrentForecast(
        userPosition: mockPosition,
      )).called(1);
    });
  });
}