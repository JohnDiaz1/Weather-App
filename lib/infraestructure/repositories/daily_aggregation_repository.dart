import 'package:realm/realm.dart';
import '../../config/db/realm_config.dart';
import '../entities/daily_aggregation_entity.dart';

class DailyAggregationRepository {
  final Realm realm;

  DailyAggregationRepository() : realm = RealmConfig.realm;

  /// Creates a safe detached copy of a DailyAggregationEntity
  DailyAggregationEntity _detachFromRealm(DailyAggregationEntity original) {
    // Create new instances of nested objects
    final cloudCover = original.cloudCover != null
        ? CloudCoverEntity(original.cloudCover!.afternoon)
        : null;

    final humidity = original.humidity != null
        ? CloudCoverEntity(original.humidity!.afternoon)
        : null;

    final precipitation = original.precipitation != null
        ? PrecipitationEntity(original.precipitation!.total)
        : null;

    final temperature = original.temperature != null
        ? TemperatureEntity(
      original.temperature!.min,
      original.temperature!.max,
      original.temperature!.afternoon,
      original.temperature!.night,
      original.temperature!.evening,
       original.temperature!.morning,
    )
        : null;

    final pressure = original.pressure != null
        ? CloudCoverEntity(original.pressure!.afternoon)
        : null;

    final windMax = original.wind?.max != null
        ? MaxEntity(
      original.wind!.max!.speed,
      original.wind!.max!.direction,
    )
        : null;

    final wind = original.wind != null
        ? WindEntity(max: windMax)
        : null;

    // Create the main entity
    return DailyAggregationEntity(
      original.id,
      original.lat,
      original.lon,
      original.tz,
      original.date,
      original.units,
      cloudCover: cloudCover,
      humidity: humidity,
      precipitation: precipitation,
      temperature: temperature,
      pressure: pressure,
      wind: wind,
    );
  }

  /// Returns a Stream of DailyAggregationEntity with safe copying
  Stream<List<DailyAggregationEntity>> getAllDailyAggregationsStream() {
    final results = realm.all<DailyAggregationEntity>();
    return results.changes.map((change) {
      return change.results.map((entity) => _detachFromRealm(entity)).toList();
    });
  }

  /// Safely saves or updates a DailyAggregation
  Future<bool> saveDailyAggregation(DailyAggregationEntity dailyAggregation) async {
    try {
      realm.write(() {
        realm.add(dailyAggregation, update: true);
      });
      return true;
    } catch (e) {
      throw Exception('Erro saving data daily aggregation: $e');
    }
  }

  /// Safely gets the latest DailyAggregation
  DailyAggregationEntity? getLatestDailyAggregation() {
    try {
      final results = realm.query<DailyAggregationEntity>('TRUEPREDICATE SORT(date DESC) LIMIT(1)');

      if (results.isEmpty) return null;

      return _detachFromRealm(results.first);
    } catch (e) {
      throw Exception('Error get data daily aggregation: $e');
    }
  }

  /// Gets all DailyAggregations safely
  List<DailyAggregationEntity> getAllDailyAggregations() {
    try {
      return realm.all<DailyAggregationEntity>()
          .map((entity) => _detachFromRealm(entity))
          .toList();
    } catch (e) {
      print('Error getting all daily aggregations: $e');
      return [];
    }
  }

  /// Safely deletes old data beyond a certain date
  Future<bool> deleteOldData(DateTime cutoffDate) async {
    try {
      final oldItems = realm.all<DailyAggregationEntity>()
          .query('date < \$0', [cutoffDate]);

      realm.write(() {
        realm.deleteMany(oldItems);
      });
      return true;
    } catch (e) {
      print('Error deleting old data: $e');
      return false;
    }
  }
}