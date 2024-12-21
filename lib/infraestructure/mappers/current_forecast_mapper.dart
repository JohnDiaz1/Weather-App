import '../../domain/models/current_forecast_model.dart';
import '../entities/current_forecast_entity.dart';

class CurrentForecastMapper {

  /// Valores por defecto para casos donde los datos son nulos
  static const _DEFAULT_TEMP = 0.0;
  static const _DEFAULT_PRESSURE = 1013;
  static const _DEFAULT_HUMIDITY = 0;
  static const _DEFAULT_VISIBILITY = 10000;
  static const _DEFAULT_WIND_SPEED = 0.0;
  static const _DEFAULT_WIND_DEG = 0;

  /// Convierte una entidad Realm a un modelo de dominio
  static CurrentForecast fromEntity(CurrentForecastEntity entity) {
    return CurrentForecast(
      lat: entity.lat,
      lon: entity.lon,
      timezone: entity.timezone,
      timezoneOffset: entity.timezoneOffset,
      current: _mapCurrentFromEntity(entity.current),
      // Convertimos explícitamente cada lista al tipo correcto
      minutely: entity.minutely.map((e) => _mapMinutelyFromEntity(e)).toList(),
      hourly: entity.hourly.map((e) => _mapCurrentFromEntity(e)).toList(),
      daily: entity.daily.map((e) => _mapDailyFromEntity(e)).toList(),
    );
  }

  /// Mapea un CurrentEntity a Current, manejando correctamente los enums
  static Current _mapCurrentFromEntity(CurrentEntity? entity) {
    if (entity == null) {
      // Creamos un Current con valores por defecto si la entidad es nula
      return Current(
        dt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        temp: _DEFAULT_TEMP,
        feelsLike: _DEFAULT_TEMP,
        pressure: _DEFAULT_PRESSURE,
        humidity: _DEFAULT_HUMIDITY,
        dewPoint: _DEFAULT_TEMP,
        uvi: 0.0,
        clouds: 0,
        visibility: _DEFAULT_VISIBILITY,
        windSpeed: _DEFAULT_WIND_SPEED,
        windDeg: _DEFAULT_WIND_DEG,
        // Creamos una lista con un Weather por defecto
        weather: [_createDefaultWeather()],
      );
    }

    return Current(
      dt: entity.dt,
      sunrise: entity.sunrise,
      sunset: entity.sunset,
      temp: entity.temp,
      feelsLike: entity.feelsLike,
      pressure: entity.pressure,
      humidity: entity.humidity,
      dewPoint: entity.dewPoint,
      uvi: entity.uvi,
      clouds: entity.clouds,
      visibility: entity.visibility,
      windSpeed: entity.windSpeed,
      windDeg: entity.windDeg,
      windGust: entity.windGust,
      pop: entity.pop,
      rain: entity.rain != null ? Rain(the1H: entity.rain!.the1H) : null,
      weather: entity.weather.map(_mapWeatherFromEntity).toList(),
    );
  }

  /// Crea un objeto Weather por defecto
  static Weather _createDefaultWeather() {
    return Weather(
      id: 800,
      main: "Clouds", // Usamos el enum correcto
      description: "Nubes", // Usamos el enum correcto
      icon: "01d",
    );
  }

  /// Mapea un WeatherEntity a Weather, manejando los enums correctamente
  static Weather _mapWeatherFromEntity(WeatherEntity entity) {
    return Weather(
      id: entity.id,
      main: entity.main,
      description: entity.description,
      icon: entity.icon,
    );
  }


  /// Mapea un MinutelyEntity a Minutely
  static Minutely _mapMinutelyFromEntity(MinutelyEntity entity) {
    return Minutely(
      dt: entity.dt,
      precipitation: entity.precipitation.toDouble(),
    );
  }

  /// Mapea un DailyEntity a Daily
  static Daily _mapDailyFromEntity(DailyEntity entity) {
    return Daily(
      dt: entity.dt,
      sunrise: entity.sunrise,
      sunset: entity.sunset,
      moonrise: entity.moonrise,
      moonset: entity.moonset,
      moonPhase: entity.moonPhase,
      summary: entity.summary,
      temp: _mapTempFromEntity(entity.temp!),
      feelsLike: _mapFeelsLikeFromEntity(entity.feelsLike!),
      pressure: entity.pressure,
      humidity: entity.humidity,
      dewPoint: entity.dewPoint,
      windSpeed: entity.windSpeed,
      windDeg: entity.windDeg,
      windGust: entity.windGust,
      weather: entity.weather.map(_mapWeatherFromEntity).toList(),
      clouds: entity.clouds,
      pop: entity.pop,
      rain: entity.rain,
      uvi: entity.uvi,
    );
  }

  /// Mapea un TempEntity a Temp
  static Temp _mapTempFromEntity(TempEntity entity) {
    return Temp(
      day: entity.day,
      min: entity.min,
      max: entity.max,
      night: entity.night,
      eve: entity.eve,
      morn: entity.morn,
    );
  }

  /// Mapea un FeelsLikeEntity a FeelsLike
  static FeelsLike _mapFeelsLikeFromEntity(FeelsLikeEntity entity) {
    return FeelsLike(
      day: entity.day,
      night: entity.night,
      eve: entity.eve,
      morn: entity.morn,
    );
  }

  ///conversion inversa
  static CurrentForecastEntity toEntity(CurrentForecast model) {
    return CurrentForecastEntity(
      model.hashCode.toString(), // Generamos un ID único
      model.lat,
      model.lon,
      model.timezone,
      model.timezoneOffset,
      current: _currentToEntity(model.current),
      minutely: model.minutely?.map(_minutelyToEntity).toList() ?? [],
      hourly: model.hourly.map(_currentToEntity).toList(),
      daily: model.daily.map(_dailyToEntity).toList(),
    );
  }

  static CurrentEntity _currentToEntity(Current model) {
    return CurrentEntity(
      model.dt,
      model.temp,
      model.feelsLike,
      model.pressure,
      model.humidity,
      model.dewPoint,
      model.uvi,
      model.clouds,
      model.visibility,
      model.windSpeed,
      model.windDeg,
      sunrise: model.sunrise,
      sunset: model.sunset,
      windGust: model.windGust,
      pop: model.pop,
      rain: model.rain != null ? RainEntity(model.rain!.the1H) : null,
      weather: model.weather.map(_weatherToEntity).toList(),
    );
  }

  static WeatherEntity _weatherToEntity(Weather model) {
    return WeatherEntity(
      model.id,
      model.main,
      model.description,
      model.icon,
    );
  }

  static MinutelyEntity _minutelyToEntity(Minutely model) {
    return MinutelyEntity(
      model.dt.toInt(),
      model.precipitation.toInt(),
    );
  }

  static DailyEntity _dailyToEntity(Daily model) {
    return DailyEntity(
      model.dt,
      model.sunrise,
      model.sunset,
      model.moonrise,
      model.moonset,
      model.moonPhase,
      model.summary,
      temp: _tempToEntity(model.temp),
      feelsLike: _feelsLikeToEntity(model.feelsLike),
      model.pressure,
      model.humidity,
      model.dewPoint,
      model.windSpeed,
      model.windDeg,
      model.windGust,
      weather: model.weather.map(_weatherToEntity).toList(),
      model.clouds,
      model.pop,
      model.rain == null ? 0.0 : model.rain!,
      model.uvi,
    );
  }

  static TempEntity _tempToEntity(Temp model) {
    return TempEntity(
      model.day,
      model.min,
      model.max,
      model.night,
      model.eve,
      model.morn,
    );
  }

  static FeelsLikeEntity _feelsLikeToEntity(FeelsLike model) {
    return FeelsLikeEntity(
      model.day,
      model.night,
      model.eve,
      model.morn,
    );
  }
}
