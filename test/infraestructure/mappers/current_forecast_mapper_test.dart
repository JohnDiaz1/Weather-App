import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:realm/realm.dart';
import 'package:weather_app/domain/models/current_forecast_model.dart';
import 'package:weather_app/infraestructure/entities/current_forecast_entity.dart';
import 'package:weather_app/infraestructure/mappers/current_forecast_mapper.dart';

// Mocks para las entidades
class MockCurrentForecastEntity extends Mock implements CurrentForecastEntity {}
class MockCurrentEntity extends Mock implements CurrentEntity {}
class MockWeatherEntity extends Mock implements WeatherEntity {}
class MockMinutelyEntity extends Mock implements MinutelyEntity {}
class MockDailyEntity extends Mock implements DailyEntity {}
class MockTempEntity extends Mock implements TempEntity {}
class MockFeelsLikeEntity extends Mock implements FeelsLikeEntity {}
class MockRainEntity extends Mock implements RainEntity {}

void main() {
  late MockCurrentForecastEntity mockCurrentForecastEntity;
  late MockCurrentEntity mockCurrentEntity;
  late MockWeatherEntity mockWeatherEntity;
  late MockRainEntity mockRainEntity;

  setUp(() {
    mockCurrentForecastEntity = MockCurrentForecastEntity();
    mockCurrentEntity = MockCurrentEntity();
    mockWeatherEntity = MockWeatherEntity();
    mockRainEntity = MockRainEntity();
  });

  group('CurrentForecastMapper Tests', () {
    test('fromEntity should map CurrentForecastEntity to CurrentForecast', () {
      // Arrange
      final weatherList = RealmList<WeatherEntity>([mockWeatherEntity]);
      final minutelyList = RealmList<MinutelyEntity>([]);
      final hourlyList = RealmList<CurrentEntity>([mockCurrentEntity]);
      final dailyList = RealmList<DailyEntity>([]);

      when(() => mockCurrentForecastEntity.lat).thenReturn(40.7128);
      when(() => mockCurrentForecastEntity.lon).thenReturn(-74.0060);
      when(() => mockCurrentForecastEntity.timezone).thenReturn('America/New_York');
      when(() => mockCurrentForecastEntity.timezoneOffset).thenReturn(-14400);
      when(() => mockCurrentForecastEntity.current).thenReturn(mockCurrentEntity);
      when(() => mockCurrentForecastEntity.minutely).thenReturn(minutelyList);
      when(() => mockCurrentForecastEntity.hourly).thenReturn(hourlyList);
      when(() => mockCurrentForecastEntity.daily).thenReturn(dailyList);

      // Configure mock current entity
      when(() => mockCurrentEntity.dt).thenReturn(1632145200);
      when(() => mockCurrentEntity.temp).thenReturn(22.5);
      when(() => mockCurrentEntity.feelsLike).thenReturn(23.0);
      when(() => mockCurrentEntity.pressure).thenReturn(1015);
      when(() => mockCurrentEntity.humidity).thenReturn(65);
      when(() => mockCurrentEntity.dewPoint).thenReturn(15.5);
      when(() => mockCurrentEntity.uvi).thenReturn(4.5);
      when(() => mockCurrentEntity.clouds).thenReturn(75);
      when(() => mockCurrentEntity.visibility).thenReturn(10000);
      when(() => mockCurrentEntity.windSpeed).thenReturn(3.5);
      when(() => mockCurrentEntity.windDeg).thenReturn(180);
      when(() => mockCurrentEntity.weather).thenReturn(weatherList);

      // Configure mock weather entity
      when(() => mockWeatherEntity.id).thenReturn(800);
      when(() => mockWeatherEntity.main).thenReturn('Clouds');
      when(() => mockWeatherEntity.description).thenReturn('Nubes');
      when(() => mockWeatherEntity.icon).thenReturn('02d');

      // Act
      final result = CurrentForecastMapper.fromEntity(mockCurrentForecastEntity);

      // Assert
      expect(result.lat, 40.7128);
      expect(result.lon, -74.0060);
      expect(result.timezone, 'America/New_York');
      expect(result.timezoneOffset, -14400);

      // Verify current weather data
      expect(result.current.temp, 22.5);
      expect(result.current.feelsLike, 23.0);
      expect(result.current.pressure, 1015);
      expect(result.current.humidity, 65);
    });

    test('fromEntity should handle null current data with default values', () {
      // Arrange
      when(() => mockCurrentForecastEntity.lat).thenReturn(40.7128);
      when(() => mockCurrentForecastEntity.lon).thenReturn(-74.0060);
      when(() => mockCurrentForecastEntity.timezone).thenReturn('America/New_York');
      when(() => mockCurrentForecastEntity.timezoneOffset).thenReturn(-14400);
      when(() => mockCurrentForecastEntity.current).thenReturn(null);
      when(() => mockCurrentForecastEntity.minutely).thenReturn(RealmList<MinutelyEntity>([]));
      when(() => mockCurrentForecastEntity.hourly).thenReturn(RealmList<CurrentEntity>([]));
      when(() => mockCurrentForecastEntity.daily).thenReturn(RealmList<DailyEntity>([]));

      // Act
      final result = CurrentForecastMapper.fromEntity(mockCurrentForecastEntity);

      // Assert
      expect(result.current.temp, 0.0); // Valor por defecto para temperatura
      expect(result.current.pressure, 1013); // Valor por defecto para presión
      expect(result.current.humidity, 0); // Valor por defecto para humedad
      expect(result.current.visibility, 10000); // Valor por defecto para visibilidad
    });

    test('toEntity should map CurrentForecast to CurrentForecastEntity', () {
      // Arrange
      final currentForecast = CurrentForecast(
        lat: 40.7128,
        lon: -74.0060,
        timezone: 'America/New_York',
        timezoneOffset: -14400,
        current: Current(
          dt: 1632145200,
          temp: 22.5,
          feelsLike: 23.0,
          pressure: 1015,
          humidity: 65,
          dewPoint: 15.5,
          uvi: 4.5,
          clouds: 75,
          visibility: 10000,
          windSpeed: 3.5,
          windDeg: 180,
          weather: [
            Weather(
              id: 800,
              main: "Clouds",
              description: "Nubes",
              icon: '02d',
            ),
          ],
        ),
        minutely: [],
        hourly: [],
        daily: [],
      );

      // Act
      final result = CurrentForecastMapper.toEntity(currentForecast);

      // Assert
      expect(result.lat, 40.7128);
      expect(result.lon, -74.0060);
      expect(result.timezone, 'America/New_York');
      expect(result.timezoneOffset, -14400);

      // Verify current weather data in entity
      expect(result.current?.temp, 22.5);
      expect(result.current?.feelsLike, 23.0);
      expect(result.current?.pressure, 1015);
      expect(result.current?.humidity, 65);
      expect(result.current?.weather.first.main, 'Clouds');
      expect(result.current?.weather.first.description, 'Nubes');
    });

    test('should correctly map rain data in full forecast', () {
      // Arrange
      final weatherList = RealmList<WeatherEntity>([mockWeatherEntity]);
      final minutelyList = RealmList<MinutelyEntity>([]);
      final hourlyList = RealmList<CurrentEntity>([]);
      final dailyList = RealmList<DailyEntity>([]);

      // Configure rain entity
      when(() => mockRainEntity.the1H).thenReturn(1.5);
      when(() => mockCurrentEntity.rain).thenReturn(mockRainEntity);

      // Configure current entity with rain
      when(() => mockCurrentEntity.dt).thenReturn(1632145200);
      when(() => mockCurrentEntity.temp).thenReturn(22.5);
      when(() => mockCurrentEntity.feelsLike).thenReturn(23.0);
      when(() => mockCurrentEntity.pressure).thenReturn(1015);
      when(() => mockCurrentEntity.humidity).thenReturn(65);
      when(() => mockCurrentEntity.dewPoint).thenReturn(15.5);
      when(() => mockCurrentEntity.uvi).thenReturn(4.5);
      when(() => mockCurrentEntity.clouds).thenReturn(75);
      when(() => mockCurrentEntity.visibility).thenReturn(10000);
      when(() => mockCurrentEntity.windSpeed).thenReturn(3.5);
      when(() => mockCurrentEntity.windDeg).thenReturn(180);
      when(() => mockCurrentEntity.weather).thenReturn(weatherList);

      // Configure forecast entity
      when(() => mockCurrentForecastEntity.lat).thenReturn(40.7128);
      when(() => mockCurrentForecastEntity.lon).thenReturn(-74.0060);
      when(() => mockCurrentForecastEntity.timezone).thenReturn('America/New_York');
      when(() => mockCurrentForecastEntity.timezoneOffset).thenReturn(-14400);
      when(() => mockCurrentForecastEntity.current).thenReturn(mockCurrentEntity);
      when(() => mockCurrentForecastEntity.minutely).thenReturn(minutelyList);
      when(() => mockCurrentForecastEntity.hourly).thenReturn(hourlyList);
      when(() => mockCurrentForecastEntity.daily).thenReturn(dailyList);

      // Configure weather entity
      when(() => mockWeatherEntity.id).thenReturn(800);
      when(() => mockWeatherEntity.main).thenReturn('Clouds');
      when(() => mockWeatherEntity.description).thenReturn('nubes');
      when(() => mockWeatherEntity.icon).thenReturn('02d');

      // Act
      final result = CurrentForecastMapper.fromEntity(mockCurrentForecastEntity);

      // Assert
      expect(result.current.rain?.the1H, 1.5);
    });
  });
}