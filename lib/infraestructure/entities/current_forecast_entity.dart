import 'package:realm/realm.dart';

part 'current_forecast_entity.realm.dart';

@RealmModel()
class _CurrentForecastEntity {
  @PrimaryKey()
  late String id;

  late double lat;
  late double lon;
  late String timezone;
  late int timezoneOffset;
  _CurrentEntity? current;
  late List<_MinutelyEntity> minutely;
  late List<_CurrentEntity> hourly;
  late List<_DailyEntity> daily;
}

@RealmModel()
class _CurrentEntity {
  late int dt;
  late int? sunrise;
  late int? sunset;
  late double temp;
  late double feelsLike;
  late int pressure;
  late int humidity;
  late double dewPoint;
  late double uvi;
  late int clouds;
  late int visibility;
  late double windSpeed;
  late int windDeg;
  late double? windGust;
  late double? pop;
  _RainEntity? rain;
  late List<_WeatherEntity> weather;
}

@RealmModel()
class _MinutelyEntity {
  late int dt;
  late int precipitation;
}

@RealmModel()
class _DailyEntity {
  late int dt;
  late int sunrise;
  late int sunset;
  late int moonrise;
  late int moonset;
  late double moonPhase;
  late String summary;
  _TempEntity? temp;
  _FeelsLikeEntity? feelsLike;

  late int pressure;
  late int humidity;
  late double dewPoint;
  late double windSpeed;
  late int windDeg;
  late double windGust;
  late int clouds;
  late double pop;
  late double rain;
  late double uvi;
  late List<_WeatherEntity> weather;
}

@RealmModel()
class _WeatherEntity {
  late int id;
  late String main;
  late String description;
  late String icon;
}

@RealmModel()
class _TempEntity {
  late double day;
  late double min;
  late double max;
  late double night;
  late double eve;
  late double morn;
}

@RealmModel()
class _FeelsLikeEntity {
  late double day;
  late double night;
  late double eve;
  late double morn;
}

@RealmModel()
class _RainEntity {
  late double the1H;
}
