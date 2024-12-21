import 'package:realm/realm.dart';
import '../../config/db/realm_config.dart';
import '../entities/current_forecast_entity.dart';

/// Repository para manejar las operaciones de base de datos relacionadas con CurrentForecast
class CurrentForecastRepository {
  final Realm _realm;

  CurrentForecastRepository({Realm? realm}) : _realm = realm ?? RealmConfig.realm;

  /// Crea una copia segura desvinculada de un CurrentForecastEntity
  CurrentForecastEntity _detachFromRealm(CurrentForecastEntity original) {
    final currentEntity = original.current != null
        ? CurrentEntity(
            original.current!.dt,
            original.current!.temp,
            original.current!.feelsLike,
            original.current!.pressure,
            original.current!.humidity,
            original.current!.dewPoint,
            original.current!.uvi,
            original.current!.clouds,
            original.current!.visibility,
            original.current!.windSpeed,
            original.current!.windDeg,
            sunrise: original.current!.sunrise,
            sunset: original.current!.sunset,
            windGust: original.current!.windGust,
            pop: original.current!.pop,
            rain: original.current!.rain != null
                ? RainEntity(original.current!.rain!.the1H)
                : null,
            weather: original.current!.weather
                .map((w) => WeatherEntity(
                      w.id,
                      w.main,
                      w.description,
                      w.icon,
                    ))
                .toList(),
          )
        : null;

    // Mapear minutely
    final minutelyList = original.minutely
        .map((m) => MinutelyEntity(
              m.dt,
              m.precipitation,
            ))
        .toList();

    // Mapear hourly
    final hourlyList = original.hourly
        .map((h) => CurrentEntity(
              h.dt,
              h.temp,
              h.feelsLike,
              h.pressure,
              h.humidity,
              h.dewPoint,
              h.uvi,
              h.clouds,
              h.visibility,
              h.windSpeed,
              h.windDeg,
              sunrise: h.sunrise,
              sunset: h.sunset,
              windGust: h.windGust,
              pop: h.pop,
              rain: h.rain != null ? RainEntity(h.rain!.the1H) : null,
              weather: h.weather
                  .map((w) => WeatherEntity(
                        w.id,
                        w.main,
                        w.description,
                        w.icon,
                      ))
                  .toList(),
            ))
        .toList();

    // Mapear daily
    final dailyList = original.daily
        .map((d) => DailyEntity(
              d.dt,
              d.sunrise,
              d.sunset,
              d.moonrise,
              d.moonset,
              d.moonPhase,
              d.summary,
              temp: d.temp != null
                  ? TempEntity(
                      d.temp!.day,
                      d.temp!.min,
                      d.temp!.max,
                      d.temp!.night,
                      d.temp!.eve,
                      d.temp!.morn,
                    )
                  : null,
              feelsLike: d.feelsLike != null
                  ? FeelsLikeEntity(
                      d.feelsLike!.day,
                      d.feelsLike!.night,
                      d.feelsLike!.eve,
                      d.feelsLike!.morn,
                    )
                  : null,
              d.pressure,
              d.humidity,
              d.dewPoint,
              d.windSpeed,
              d.windDeg,
              d.windGust,
              d.clouds,
              d.pop,
              d.rain,
              d.uvi,
              weather: d.weather
                  .map((w) => WeatherEntity(
                        w.id,
                        w.main,
                        w.description,
                        w.icon,
                      ))
                  .toList(),
            ))
        .toList();

    return CurrentForecastEntity(
      original.id,
      original.lat,
      original.lon,
      original.timezone,
      original.timezoneOffset,
      current: currentEntity,
      minutely: minutelyList,
      hourly: hourlyList,
      daily: dailyList,
    );
  }

  /// Obtiene el último pronóstico guardado
  CurrentForecastEntity? getLatestForecast() {
    try {
      final results = _realm.query<CurrentForecastEntity>(
          'TRUEPREDICATE SORT(current.dt DESC) LIMIT(1)');

      if (results.isEmpty) return null;

      return _detachFromRealm(results.first);
    } catch (e) {
      throw Exception('Error getting latest forecast: $e');
    }
  }

  /// Guarda o actualiza un pronóstico
  Future<bool> saveForecast(CurrentForecastEntity forecast) async {
    try {
      _realm.write(() {
        _realm.add(forecast, update: true);
      });
      return true;
    } catch (e) {
      throw Exception('Error saving forecast: $e');
    }
  }

  /// Obtiene un Stream de cambios en el pronóstico
  Stream<List<CurrentForecastEntity>> getForecastStream() {
    final results = _realm.all<CurrentForecastEntity>();
    return results.changes.map((change) {
      return change.results.map((entity) => _detachFromRealm(entity)).toList();
    });
  }

  /// Elimina pronósticos antiguos
  Future<bool> deleteOldForecasts(DateTime cutoffDate) async {
    try {
      final timestamp = cutoffDate.millisecondsSinceEpoch ~/ 1000;
      final oldItems = _realm
          .all<CurrentForecastEntity>()
          .query('current.dt < \$0', [timestamp]);

      _realm.write(() {
        _realm.deleteMany(oldItems);
      });
      return true;
    } catch (e) {
      throw Exception('Error deleting old forecasts: $e');
    }
  }
}
