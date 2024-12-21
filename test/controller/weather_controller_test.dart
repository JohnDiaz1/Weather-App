import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/domain/models/current_forecast_model.dart';
import 'package:weather_app/domain/models/daily_aggregation_model.dart';

// Mock classes
class MockWeatherServices extends Mock implements WeatherServices {}
class MockPosition extends Mock implements Position {}
class MockResponse extends Mock implements http.Response {}

void main() {
  late WeatherController weatherController;
  late MockWeatherServices mockWeatherServices;
  late MockPosition mockPosition;
  late MockResponse mockResponse;

  setUp(() {
    mockWeatherServices = MockWeatherServices();
    mockPosition = MockPosition();
    mockResponse = MockResponse();
    weatherController = WeatherController(weatherServices: mockWeatherServices);

    // Set up common position values
    when(() => mockPosition.latitude).thenReturn(40.7128);
    when(() => mockPosition.longitude).thenReturn(-74.0060);
  });

  group('getCurrentForecast', () {
    const successfulResponse = '''
    {
      "lat": 40.7128,
      "lon": -74.0060,
      "timezone": "America/New_York",
      "timezone_offset": -18000,
      "current": {
        "dt": 1635777600,
        "temp": 15.5,
        "feels_like": 14.8,
        "pressure": 1015,
        "humidity": 76,
        "dew_point": 11.2,
        "uvi": 0,
        "clouds": 75,
        "visibility": 10000,
        "wind_speed": 2.1,
        "wind_deg": 220,
        "weather": [
          {
            "id": 803,
            "main": "Clouds",
            "description": "nubes dispersas",
            "icon": "04n"
          }
        ]
      },
      "minutely": [],
      "hourly": [],
      "daily": []
    }
    ''';

    test('returns CurrentForecast when API call is successful', () async {
      // Arrange
      when(() => mockResponse.statusCode).thenReturn(200);
      when(() => mockResponse.body).thenReturn(successfulResponse);
      when(() => mockWeatherServices.getCurrentForecast(
        userPosition: mockPosition,
      )).thenAnswer((_) async => mockResponse);

      // Act
      final result = await weatherController.getCurrentForecast(
        userPosition: mockPosition,
      );

      // Assert
      expect(result, isA<CurrentForecast>());
      expect(result.lat, equals(40.7128));
      expect(result.lon, equals(-74.0060));
      verify(() => mockWeatherServices.getCurrentForecast(
        userPosition: mockPosition,
      )).called(1);
    });

    test('throws exception when API call fails', () async {
      // Arrange
      when(() => mockResponse.statusCode).thenReturn(404);
      when(() => mockResponse.body).thenReturn('Not Found');
      when(() => mockWeatherServices.getCurrentForecast(
        userPosition: mockPosition,
      )).thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(
            () => weatherController.getCurrentForecast(userPosition: mockPosition),
        throwsException,
      );
    });

    test('throws exception when API call throws error', () async {
      // Arrange
      when(() => mockWeatherServices.getCurrentForecast(
        userPosition: mockPosition,
      )).thenThrow(Exception('Network error'));

      // Act & Assert
      expect(
            () => weatherController.getCurrentForecast(userPosition: mockPosition),
        throwsException,
      );
    });
  });

  group('getDailyAggregation', () {
    const successfulResponse = '''
    {
      "lat": 40.7128,
      "lon": -74.0060,
      "tz": "America/New_York",
      "date": "2024-12-21",
      "units": "metric",
      "cloud_cover": {
        "afternoon": 75
      },
      "humidity": {
        "afternoon": 76
      },
      "precipitation": {
        "total": 0
      },
      "temperature": {
        "min": 10.5,
        "max": 20.5,
        "afternoon": 18.5,
        "night": 12.5,
        "evening": 15.5,
        "morning": 11.5
      },
      "pressure": {
        "afternoon": 1015
      },
      "wind": {
        "max": {
          "speed": 5.2,
          "direction": 220
        }
      }
    }
    ''';

    test('returns DailyAggregation when API call is successful', () async {
      // Arrange
      when(() => mockResponse.statusCode).thenReturn(200);
      when(() => mockResponse.body).thenReturn(successfulResponse);
      when(() => mockWeatherServices.getDailyAggregation(
        userPosition: mockPosition,
        date: any(named: 'date'),
      )).thenAnswer((_) async => mockResponse);

      // Act
      final result = await weatherController.getDailyAggregation(
        userPosition: mockPosition,
        date: '2024-12-21',
      );

      // Assert
      expect(result, isA<DailyAggregation>());
      expect(result.lat, equals(40.7128));
      expect(result.lon, equals(-74.0060));
      verify(() => mockWeatherServices.getDailyAggregation(
        userPosition: mockPosition,
        date: '2024-12-21',
      )).called(1);
    });

    test('throws exception when API call fails', () async {
      // Arrange
      when(() => mockResponse.statusCode).thenReturn(404);
      when(() => mockResponse.body).thenReturn('Not Found');
      when(() => mockWeatherServices.getDailyAggregation(
        userPosition: mockPosition,
        date: any(named: 'date'),
      )).thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(
            () => weatherController.getDailyAggregation(
          userPosition: mockPosition,
          date: '2024-12-21',
        ),
        throwsException,
      );
    });

    test('throws exception when API call throws error', () async {
      // Arrange
      when(() => mockWeatherServices.getDailyAggregation(
        userPosition: mockPosition,
        date: any(named: 'date'),
      )).thenThrow(Exception('Network error'));

      // Act & Assert
      expect(
            () => weatherController.getDailyAggregation(
          userPosition: mockPosition,
          date: '2024-12-21',
        ),
        throwsException,
      );
    });
  });
}