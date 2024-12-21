import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/domain/models/daily_aggregation_model.dart';
import 'package:weather_app/infraestructure/entities/daily_aggregation_entity.dart';
import 'package:weather_app/infraestructure/mappers/daily_aggregation_mapper.dart';

// Mocks para las entidades
class MockDailyAggregationEntity extends Mock implements DailyAggregationEntity {}
class MockCloudCoverEntity extends Mock implements CloudCoverEntity {}
class MockPrecipitationEntity extends Mock implements PrecipitationEntity {}
class MockTemperatureEntity extends Mock implements TemperatureEntity {}
class MockWindEntity extends Mock implements WindEntity {}
class MockMaxEntity extends Mock implements MaxEntity {}

void main() {
  late MockDailyAggregationEntity mockEntity;
  late MockCloudCoverEntity mockCloudCover;
  late MockPrecipitationEntity mockPrecipitation;
  late MockTemperatureEntity mockTemperature;
  late MockWindEntity mockWind;
  late MockMaxEntity mockMax;

  setUp(() {
    mockEntity = MockDailyAggregationEntity();
    mockCloudCover = MockCloudCoverEntity();
    mockPrecipitation = MockPrecipitationEntity();
    mockTemperature = MockTemperatureEntity();
    mockWind = MockWindEntity();
    mockMax = MockMaxEntity();
  });

  group('DailyAggregationMapper Tests', () {
    test('fromEntity should map complete entity to model correctly', () {
      // Arrange
      final testDate = DateTime(2024, 1, 1);

      when(() => mockEntity.lat).thenReturn(40.7128);
      when(() => mockEntity.lon).thenReturn(-74.0060);
      when(() => mockEntity.tz).thenReturn('America/New_York');
      when(() => mockEntity.date).thenReturn(testDate);
      when(() => mockEntity.units).thenReturn('metric');
      when(() => mockEntity.cloudCover).thenReturn(mockCloudCover);
      when(() => mockEntity.humidity).thenReturn(mockCloudCover);
      when(() => mockEntity.precipitation).thenReturn(mockPrecipitation);
      when(() => mockEntity.temperature).thenReturn(mockTemperature);
      when(() => mockEntity.pressure).thenReturn(mockCloudCover);
      when(() => mockEntity.wind).thenReturn(mockWind);

      when(() => mockCloudCover.afternoon).thenReturn(75.5);
      when(() => mockPrecipitation.total).thenReturn(25.4);

      when(() => mockTemperature.min).thenReturn(18.5);
      when(() => mockTemperature.max).thenReturn(28.5);
      when(() => mockTemperature.afternoon).thenReturn(27.0);
      when(() => mockTemperature.night).thenReturn(20.0);
      when(() => mockTemperature.evening).thenReturn(23.0);
      when(() => mockTemperature.morning).thenReturn(19.0);

      when(() => mockWind.max).thenReturn(mockMax);
      when(() => mockMax.speed).thenReturn(15.5);
      when(() => mockMax.direction).thenReturn(180.0);

      // Act
      final result = DailyAggregationMapper.fromEntity(mockEntity);

      // Assert
      expect(result.lat, 40.7128);
      expect(result.lon, -74.0060);
      expect(result.tz, 'America/New_York');
      expect(result.date, testDate);
      expect(result.units, 'metric');

      expect(result.cloudCover.afternoon, 75.5);
      expect(result.humidity.afternoon, 75.5);
      expect(result.precipitation.total, 25.4);

      expect(result.temperature.min, 18.5);
      expect(result.temperature.max, 28.5);
      expect(result.temperature.afternoon, 27.0);
      expect(result.temperature.night, 20.0);
      expect(result.temperature.evening, 23.0);
      expect(result.temperature.morning, 19.0);

      expect(result.pressure.afternoon, 75.5);
      expect(result.wind.max.speed, 15.5);
      expect(result.wind.max.direction, 180.0);
    });

    test('fromEntity should handle null values with defaults', () {
      // Arrange
      final testDate = DateTime(2024, 1, 1);

      when(() => mockEntity.lat).thenReturn(40.7128);
      when(() => mockEntity.lon).thenReturn(-74.0060);
      when(() => mockEntity.tz).thenReturn('America/New_York');
      when(() => mockEntity.date).thenReturn(testDate);
      when(() => mockEntity.units).thenReturn('metric');
      when(() => mockEntity.cloudCover).thenReturn(null);
      when(() => mockEntity.humidity).thenReturn(null);
      when(() => mockEntity.precipitation).thenReturn(null);
      when(() => mockEntity.temperature).thenReturn(null);
      when(() => mockEntity.pressure).thenReturn(null);
      when(() => mockEntity.wind).thenReturn(null);

      // Act
      final result = DailyAggregationMapper.fromEntity(mockEntity);

      // Assert
      expect(result.cloudCover.afternoon, 0.0);
      expect(result.humidity.afternoon, 0.0);
      expect(result.precipitation.total, 0.0);
      expect(result.temperature.min, 0.0);
      expect(result.temperature.max, 0.0);
      expect(result.wind.max.speed, 0.0);
      expect(result.wind.max.direction, 0.0);
    });

    test('toEntity should map model to entity correctly', () {
      // Arrange
      final testDate = DateTime(2024, 1, 1);
      final model = DailyAggregation(
        lat: 40.7128,
        lon: -74.0060,
        tz: 'America/New_York',
        date: testDate,
        units: 'metric',
        cloudCover: CloudCover(afternoon: 75.5),
        humidity: CloudCover(afternoon: 65.0),
        precipitation: Precipitation(total: 25.4),
        temperature: Temperature(
          min: 18.5,
          max: 28.5,
          afternoon: 27.0,
          night: 20.0,
          evening: 23.0,
          morning: 19.0,
        ),
        pressure: CloudCover(afternoon: 1015.0),
        wind: Wind(max: Max(speed: 15.5, direction: 180.0)),
      );

      // Act
      final result = DailyAggregationMapper.toEntity(model);

      // Assert
      expect(result.lat, 40.7128);
      expect(result.lon, -74.0060);
      expect(result.tz, 'America/New_York');
      expect(result.date, testDate);
      expect(result.units, 'metric');

      expect(result.cloudCover?.afternoon, 75.5);
      expect(result.humidity?.afternoon, 65.0);
      expect(result.precipitation?.total, 25.4);

      expect(result.temperature?.min, 18.5);
      expect(result.temperature?.max, 28.5);
      expect(result.temperature?.afternoon, 27.0);
      expect(result.temperature?.night, 20.0);
      expect(result.temperature?.evening, 23.0);
      expect(result.temperature?.morning, 19.0);

      expect(result.pressure?.afternoon, 1015.0);
      expect(result.wind?.max?.speed, 15.5);
      expect(result.wind?.max?.direction, 180.0);
    });
  });
}