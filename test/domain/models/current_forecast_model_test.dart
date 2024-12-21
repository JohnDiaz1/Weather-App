import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:weather_app/domain/models/current_forecast_model.dart';


// Creamos los mocks necesarios
class MockCurrentForecast extends Mock implements CurrentForecast {}
class MockCurrent extends Mock implements Current {}
class MockDaily extends Mock implements Daily {}
class MockWeather extends Mock implements Weather {}

void main() {
  group('CurrentForecast Tests', () {
    // Datos de ejemplo para las pruebas
    final jsonMap = {
      "lat": 40.416775,
      "lon": -3.703790,
      "timezone": "Europe/Madrid",
      "timezone_offset": 3600,
      "current": {
        "dt": 1616947320,
        "sunrise": 1616914897,
        "sunset": 1616959270,
        "temp": 18.5,
        "feels_like": 17.8,
        "pressure": 1016,
        "humidity": 55,
        "dew_point": 9.2,
        "uvi": 3.1,
        "clouds": 75,
        "visibility": 10000,
        "wind_speed": 2.1,
        "wind_deg": 230,
        "weather": [
          {
            "id": 803,
            "main": "Clouds",
            "description": "nubes dispersas",
            "icon": "04d"
          }
        ]
      },
      "minutely": [
        {
          "dt": 1616947320,
          "precipitation": 0
        }
      ],
      "hourly": [],
      "daily": []
    };

    test('fromJson crea una instancia válida de CurrentForecast', () {
      // Cuando
      final forecast = CurrentForecast.fromJson(jsonMap);

      // Entonces
      expect(forecast, isA<CurrentForecast>());
      expect(forecast.lat, equals(40.416775));
      expect(forecast.lon, equals(-3.703790));
      expect(forecast.timezone, equals("Europe/Madrid"));
      expect(forecast.timezoneOffset, equals(3600));
    });

    test('Current fromJson crea una instancia válida', () {
      // Dado
      final currentJson = jsonMap['current'] as Map<String, dynamic>;

      // Cuando
      final current = Current.fromJson(currentJson);

      // Entonces
      expect(current.temp, equals(18.5));
      expect(current.feelsLike, equals(17.8));
      expect(current.pressure, equals(1016));
      expect(current.humidity, equals(55));
    });

    test('toJson genera un JSON válido', () {
      // Dado
      final forecast = CurrentForecast.fromJson(jsonMap);

      // Cuando
      final generatedJson = forecast.toJson();

      // Entonces
      expect(generatedJson['lat'], equals(40.416775));
      expect(generatedJson['lon'], equals(-3.703790));
      expect(generatedJson['timezone'], equals("Europe/Madrid"));
      expect(generatedJson['timezone_offset'], equals(3600));
    });

    test('Rain fromJson maneja correctamente datos nulos', () {
      // Dado
      final jsonWithRain = {
        "1h": 0.5
      };

      // Cuando
      final rain = Rain.fromJson(jsonWithRain);

      // Entonces
      expect(rain.the1H, equals(0.5));
    });

    test('Current maneja correctamente datos opcionales', () {
      // Dado
      final currentJsonWithNulls = {
        "dt": 1616947320,
        "temp": 18.5,
        "feels_like": 17.8,
        "pressure": 1016,
        "humidity": 55,
        "dew_point": 9.2,
        "uvi": 3.1,
        "clouds": 75,
        "visibility": 10000,
        "wind_speed": 2.1,
        "wind_deg": 230,
        "weather": []
      };

      // Cuando
      final current = Current.fromJson(currentJsonWithNulls);

      // Entonces
      expect(current.sunrise, isNull);
      expect(current.sunset, isNull);
      expect(current.windGust, isNull);
      expect(current.pop, isNull);
      expect(current.rain, isNull);
    });
  });

  group('Daily Tests', () {
    final dailyJson = {
      "dt": 1616947320,
      "sunrise": 1616914897,
      "sunset": 1616959270,
      "moonrise": 1616914897,
      "moonset": 1616959270,
      "moon_phase": 0.5,
      "summary": "Día parcialmente nublado",
      "temp": {
        "day": 18.5,
        "min": 12.0,
        "max": 22.0,
        "night": 15.0,
        "eve": 17.0,
        "morn": 13.0
      },
      "feels_like": {
        "day": 17.8,
        "night": 14.5,
        "eve": 16.5,
        "morn": 12.5
      },
      "pressure": 1016,
      "humidity": 55,
      "dew_point": 9.2,
      "wind_speed": 2.1,
      "wind_deg": 230,
      "wind_gust": 3.5,
      "weather": [
        {
          "id": 803,
          "main": "Clouds",
          "description": "nubes dispersas",
          "icon": "04d"
        }
      ],
      "clouds": 75,
      "pop": 0.2,
      "rain": 0.0,
      "uvi": 3.1
    };

    test('Daily fromJson crea una instancia válida', () {
      // Cuando
      final daily = Daily.fromJson(dailyJson);

      // Entonces
      expect(daily.dt, equals(1616947320));
      expect(daily.moonPhase, equals(0.5));
      expect(daily.summary, equals("Día parcialmente nublado"));
      expect(daily.temp.day, equals(18.5));
      expect(daily.temp.min, equals(12.0));
      expect(daily.feelsLike.day, equals(17.8));
    });

    test('Temp fromJson maneja correctamente todos los valores', () {
      // Dado
      final tempJson = dailyJson['temp'] as Map<String, dynamic>;

      // Cuando
      final temp = Temp.fromJson(tempJson);

      // Entonces
      expect(temp.day, equals(18.5));
      expect(temp.min, equals(12.0));
      expect(temp.max, equals(22.0));
      expect(temp.night, equals(15.0));
      expect(temp.eve, equals(17.0));
      expect(temp.morn, equals(13.0));
    });
  });
}