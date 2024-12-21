import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'dart:convert';

import 'package:weather_app/domain/models/daily_aggregation_model.dart';


// Definimos las clases mock para pruebas más específicas
class MockDailyAggregation extends Mock implements DailyAggregation {}
class MockTemperature extends Mock implements Temperature {}
class MockWind extends Mock implements Wind {}
class MockMax extends Mock implements Max {}

void main() {
  group('DailyAggregation Model Tests', () {
    // Creamos datos de ejemplo que usaremos en múltiples pruebas
    final sampleJson = {
      "lat": 40.416775,
      "lon": -3.703790,
      "tz": "Europe/Madrid",
      "date": "2024-03-21",
      "units": "metric",
      "cloud_cover": {
        "afternoon": 65.5
      },
      "humidity": {
        "afternoon": 45.8
      },
      "precipitation": {
        "total": 2.5
      },
      "temperature": {
        "min": 12.5,
        "max": 25.3,
        "afternoon": 23.1,
        "night": 15.4,
        "evening": 18.7,
        "morning": 13.2
      },
      "pressure": {
        "afternoon": 1015.5
      },
      "wind": {
        "max": {
          "speed": 25.7,
          "direction": 180.5
        }
      }
    };

    test('DailyAggregation.fromJson crea una instancia válida', () {
      // Cuando creamos una instancia desde JSON
      final aggregation = DailyAggregation.fromJson(sampleJson);

      // Entonces verificamos que todos los campos se hayan parseado correctamente
      expect(aggregation.lat, equals(40.416775));
      expect(aggregation.lon, equals(-3.703790));
      expect(aggregation.tz, equals("Europe/Madrid"));
      expect(aggregation.units, equals("metric"));

      // Verificamos que la fecha se parseó correctamente
      expect(aggregation.date.year, equals(2024));
      expect(aggregation.date.month, equals(3));
      expect(aggregation.date.day, equals(21));
    });

    test('DailyAggregation.toJson genera un JSON válido con formato de fecha correcto', () {
      // Dado un objeto DailyAggregation
      final aggregation = DailyAggregation.fromJson(sampleJson);

      // Cuando lo convertimos a JSON
      final generatedJson = aggregation.toJson();

      // Entonces verificamos el formato correcto de la fecha
      expect(generatedJson['date'], equals('2024-03-21'));
      // Y verificamos otros campos importantes
      expect(generatedJson['lat'], equals(40.416775));
      expect(generatedJson['lon'], equals(-3.703790));
    });

    test('Temperature maneja correctamente todos los valores de temperatura', () {
      // Dado el JSON de temperatura
      final tempJson = sampleJson['temperature'] as Map<String, dynamic>;

      // Cuando creamos el objeto Temperature
      final temperature = Temperature.fromJson(tempJson);

      // Entonces verificamos todos los valores
      expect(temperature.min, equals(12.5));
      expect(temperature.max, equals(25.3));
      expect(temperature.afternoon, equals(23.1));
      expect(temperature.night, equals(15.4));
      expect(temperature.evening, equals(18.7));
      expect(temperature.morning, equals(13.2));
    });

    test('Wind.fromJson parsea correctamente la estructura anidada', () {
      // Dado el JSON de viento
      final windJson = sampleJson['wind'] as Map<String, dynamic>;

      // Cuando creamos el objeto Wind
      final wind = Wind.fromJson(windJson);

      // Entonces verificamos los valores anidados
      expect(wind.max.speed, equals(25.7));
      expect(wind.max.direction, equals(180.5));
    });

    test('CloudCover maneja correctamente los valores', () {
      // Dado el JSON de cobertura de nubes
      final cloudJson = sampleJson['cloud_cover'] as Map<String, dynamic>;

      // Cuando creamos el objeto CloudCover
      final cloudCover = CloudCover.fromJson(cloudJson);

      // Entonces verificamos el valor
      expect(cloudCover.afternoon, equals(65.5));
    });

    test('Precipitation maneja correctamente el total', () {
      // Dado el JSON de precipitación
      final precipJson = sampleJson['precipitation'] as Map<String, dynamic>;

      // Cuando creamos el objeto Precipitation
      final precip = Precipitation.fromJson(precipJson);

      // Entonces verificamos el valor total
      expect(precip.total, equals(2.5));
    });

    // Prueba para verificar el manejo de valores nulos
    test('DailyAggregation maneja correctamente valores nulos o faltantes', () {
      final jsonWithNulls = Map<String, dynamic>.from(sampleJson);
      jsonWithNulls['cloud_cover'] = {'afternoon': null};

      // No debería lanzar una excepción
      expect(() => DailyAggregation.fromJson(jsonWithNulls), returnsNormally);
    });

    test('Max.toJson genera un JSON válido', () {
      // Dado un objeto Max
      final max = Max(speed: 25.7, direction: 180.5);

      // Cuando lo convertimos a JSON
      final json = max.toJson();

      // Entonces verificamos la estructura
      expect(json, equals({
        'speed': 25.7,
        'direction': 180.5
      }));
    });

    test('dailyAggregationFromJson parsea correctamente una cadena JSON', () {
      // Dado un string JSON válido
      final jsonString = json.encode(sampleJson);

      // Cuando parseamos el string
      final aggregation = dailyAggregationFromJson(jsonString);

      // Entonces verificamos que se creó correctamente
      expect(aggregation, isA<DailyAggregation>());
      expect(aggregation.lat, equals(40.416775));
      expect(aggregation.date, isA<DateTime>());
    });

    test('dailyAggregationToJson genera una cadena JSON válida', () {
      // Dado un objeto DailyAggregation
      final aggregation = DailyAggregation.fromJson(sampleJson);

      // Cuando lo convertimos a string JSON
      final jsonString = dailyAggregationToJson(aggregation);

      // Entonces verificamos que podemos parsearlo de vuelta
      final parsed = json.decode(jsonString);
      expect(parsed['lat'], equals(40.416775));
      expect(parsed['lon'], equals(-3.703790));
    });
  });
}