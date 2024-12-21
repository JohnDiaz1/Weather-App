import '../../domain/models/daily_aggregation_model.dart';
import '../entities/daily_aggregation_entity.dart';

class DailyAggregationMapper {
  /// Valores por defecto para cuando los campos son nulos
  static const _DEFAULT_AFTERNOON_VALUE = 0.0;
  static const _DEFAULT_TOTAL_PRECIPITATION = 0.0;
  static const _DEFAULT_TEMPERATURE = 0.0;
  static const _DEFAULT_WIND_SPEED = 0.0;
  static const _DEFAULT_WIND_DIRECTION = 0.0;

  /// Convierte una entidad a un modelo de dominio, proporcionando valores por defecto
  /// cuando sea necesario para mantener la integridad de los datos
  static DailyAggregation fromEntity(DailyAggregationEntity entity) {
    return DailyAggregation(
      lat: entity.lat,
      lon: entity.lon,
      tz: entity.tz,
      date: entity.date,
      units: entity.units,
      cloudCover: _mapCloudCover(entity.cloudCover),
      humidity: _mapCloudCover(entity.humidity),
      precipitation: _mapPrecipitation(entity.precipitation),
      temperature: _mapTemperature(entity.temperature),
      pressure: _mapCloudCover(entity.pressure),
      wind: _mapWind(entity.wind),
    );
  }

  /// Mapea CloudCover con un valor por defecto si es nulo
  static CloudCover _mapCloudCover(CloudCoverEntity? entity) {
    return CloudCover(
      afternoon: entity?.afternoon ?? _DEFAULT_AFTERNOON_VALUE,
    );
  }

  /// Mapea Precipitation con un valor por defecto si es nulo
  static Precipitation _mapPrecipitation(PrecipitationEntity? entity) {
    return Precipitation(
      total: entity?.total ?? _DEFAULT_TOTAL_PRECIPITATION,
    );
  }

  /// Mapea Temperature con valores por defecto si es nulo
  static Temperature _mapTemperature(TemperatureEntity? entity) {
    return Temperature(
      min: entity?.min ?? _DEFAULT_TEMPERATURE,
      max: entity?.max ?? _DEFAULT_TEMPERATURE,
      afternoon: entity?.afternoon ?? _DEFAULT_TEMPERATURE,
      night: entity?.night ?? _DEFAULT_TEMPERATURE,
      evening: entity?.evening ?? _DEFAULT_TEMPERATURE,
      morning: entity?.morning ?? _DEFAULT_TEMPERATURE,
    );
  }

  /// Mapea Wind con valores por defecto si es nulo
  static Wind _mapWind(WindEntity? entity) {
    return Wind(
      max: Max(
        speed: entity?.max?.speed ?? _DEFAULT_WIND_SPEED,
        direction: entity?.max?.direction ?? _DEFAULT_WIND_DIRECTION,
      ),
    );
  }

  /// Convierte un modelo de dominio a una entidad
  static DailyAggregationEntity toEntity(DailyAggregation model) {
    return DailyAggregationEntity(
      model.date.toIso8601String(),
      model.lat,
      model.lon,
      model.tz,
      model.date,
      model.units,
      cloudCover: CloudCoverEntity(model.cloudCover.afternoon!),
      humidity: CloudCoverEntity(model.humidity.afternoon!),
      precipitation: PrecipitationEntity(model.precipitation.total),
      temperature: TemperatureEntity(
        model.temperature.min!,
        model.temperature.max!,
        model.temperature.afternoon!,
        model.temperature.night!,
        model.temperature.evening!,
        model.temperature.morning!,
      ),
      pressure: CloudCoverEntity(model.pressure.afternoon!),
      wind: WindEntity(
        max: MaxEntity(
          model.wind.max.speed!,
          model.wind.max.direction!,
        ),
      ),
    );
  }
}