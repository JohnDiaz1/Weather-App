import 'package:realm/realm.dart';
part 'daily_aggregation_entity.realm.dart';


@RealmModel()
class _DailyAggregationEntity {

  @PrimaryKey()
  late String id;

  late double lat;
  late double lon;
  late String tz;
  late DateTime date;
  late String units;
  _CloudCoverEntity? cloudCover;
  _CloudCoverEntity? humidity;
  _PrecipitationEntity? precipitation;
  _TemperatureEntity? temperature;
  _CloudCoverEntity? pressure;
  _WindEntity? wind;
}

@RealmModel()
class _CloudCoverEntity {
  late double afternoon;
}

@RealmModel()
class _PrecipitationEntity {
  late double total;
}

@RealmModel()
class _TemperatureEntity {
  late double min;
  late double max;
  late double afternoon;
  late double night;
  late double evening;
  late double morning;
}

@RealmModel()
class _WindEntity {
  _MaxEntity? max;
}

@RealmModel()
class _MaxEntity {
  late double speed;
  late double direction;
}