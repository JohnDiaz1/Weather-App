import 'package:realm/realm.dart';
import 'package:weather_app/infraestructure/entities/current_forecast_entity.dart';
import 'package:weather_app/infraestructure/entities/place_entity.dart';


import '../../infraestructure/entities/daily_aggregation_entity.dart';

class RealmConfig {
  static late Realm realm;

  static void initializeRealm() {
    final config = Configuration.local([
      CurrentForecastEntity.schema,
      RainEntity.schema,
      MinutelyEntity.schema,
      WeatherEntity.schema,
      CurrentEntity.schema,
      DailyEntity.schema,
      TempEntity.schema,
      FeelsLikeEntity.schema,
      PlaceEntity.schema,
      DailyAggregationEntity.schema,
      CloudCoverEntity.schema,
      PrecipitationEntity.schema,
      TemperatureEntity.schema,
      WindEntity.schema,
      MaxEntity.schema,
    ]);
    realm = Realm(config);
  }
}