// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_forecast_entity.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class CurrentForecastEntity extends _CurrentForecastEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  CurrentForecastEntity(
    String id,
    double lat,
    double lon,
    String timezone,
    int timezoneOffset, {
    CurrentEntity? current,
    Iterable<MinutelyEntity> minutely = const [],
    Iterable<CurrentEntity> hourly = const [],
    Iterable<DailyEntity> daily = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'lat', lat);
    RealmObjectBase.set(this, 'lon', lon);
    RealmObjectBase.set(this, 'timezone', timezone);
    RealmObjectBase.set(this, 'timezoneOffset', timezoneOffset);
    RealmObjectBase.set(this, 'current', current);
    RealmObjectBase.set<RealmList<MinutelyEntity>>(
        this, 'minutely', RealmList<MinutelyEntity>(minutely));
    RealmObjectBase.set<RealmList<CurrentEntity>>(
        this, 'hourly', RealmList<CurrentEntity>(hourly));
    RealmObjectBase.set<RealmList<DailyEntity>>(
        this, 'daily', RealmList<DailyEntity>(daily));
  }

  CurrentForecastEntity._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  double get lat => RealmObjectBase.get<double>(this, 'lat') as double;
  @override
  set lat(double value) => RealmObjectBase.set(this, 'lat', value);

  @override
  double get lon => RealmObjectBase.get<double>(this, 'lon') as double;
  @override
  set lon(double value) => RealmObjectBase.set(this, 'lon', value);

  @override
  String get timezone =>
      RealmObjectBase.get<String>(this, 'timezone') as String;
  @override
  set timezone(String value) => RealmObjectBase.set(this, 'timezone', value);

  @override
  int get timezoneOffset =>
      RealmObjectBase.get<int>(this, 'timezoneOffset') as int;
  @override
  set timezoneOffset(int value) =>
      RealmObjectBase.set(this, 'timezoneOffset', value);

  @override
  CurrentEntity? get current =>
      RealmObjectBase.get<CurrentEntity>(this, 'current') as CurrentEntity?;
  @override
  set current(covariant CurrentEntity? value) =>
      RealmObjectBase.set(this, 'current', value);

  @override
  RealmList<MinutelyEntity> get minutely =>
      RealmObjectBase.get<MinutelyEntity>(this, 'minutely')
          as RealmList<MinutelyEntity>;
  @override
  set minutely(covariant RealmList<MinutelyEntity> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<CurrentEntity> get hourly =>
      RealmObjectBase.get<CurrentEntity>(this, 'hourly')
          as RealmList<CurrentEntity>;
  @override
  set hourly(covariant RealmList<CurrentEntity> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<DailyEntity> get daily =>
      RealmObjectBase.get<DailyEntity>(this, 'daily') as RealmList<DailyEntity>;
  @override
  set daily(covariant RealmList<DailyEntity> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<CurrentForecastEntity>> get changes =>
      RealmObjectBase.getChanges<CurrentForecastEntity>(this);

  @override
  Stream<RealmObjectChanges<CurrentForecastEntity>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<CurrentForecastEntity>(this, keyPaths);

  @override
  CurrentForecastEntity freeze() =>
      RealmObjectBase.freezeObject<CurrentForecastEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'lat': lat.toEJson(),
      'lon': lon.toEJson(),
      'timezone': timezone.toEJson(),
      'timezoneOffset': timezoneOffset.toEJson(),
      'current': current.toEJson(),
      'minutely': minutely.toEJson(),
      'hourly': hourly.toEJson(),
      'daily': daily.toEJson(),
    };
  }

  static EJsonValue _toEJson(CurrentForecastEntity value) => value.toEJson();
  static CurrentForecastEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'lat': EJsonValue lat,
        'lon': EJsonValue lon,
        'timezone': EJsonValue timezone,
        'timezoneOffset': EJsonValue timezoneOffset,
      } =>
        CurrentForecastEntity(
          fromEJson(id),
          fromEJson(lat),
          fromEJson(lon),
          fromEJson(timezone),
          fromEJson(timezoneOffset),
          current: fromEJson(ejson['current']),
          minutely: fromEJson(ejson['minutely']),
          hourly: fromEJson(ejson['hourly']),
          daily: fromEJson(ejson['daily']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(CurrentForecastEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, CurrentForecastEntity,
        'CurrentForecastEntity', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('lat', RealmPropertyType.double),
      SchemaProperty('lon', RealmPropertyType.double),
      SchemaProperty('timezone', RealmPropertyType.string),
      SchemaProperty('timezoneOffset', RealmPropertyType.int),
      SchemaProperty('current', RealmPropertyType.object,
          optional: true, linkTarget: 'CurrentEntity'),
      SchemaProperty('minutely', RealmPropertyType.object,
          linkTarget: 'MinutelyEntity',
          collectionType: RealmCollectionType.list),
      SchemaProperty('hourly', RealmPropertyType.object,
          linkTarget: 'CurrentEntity',
          collectionType: RealmCollectionType.list),
      SchemaProperty('daily', RealmPropertyType.object,
          linkTarget: 'DailyEntity', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class CurrentEntity extends _CurrentEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  CurrentEntity(
    int dt,
    double temp,
    double feelsLike,
    int pressure,
    int humidity,
    double dewPoint,
    double uvi,
    int clouds,
    int visibility,
    double windSpeed,
    int windDeg, {
    int? sunrise,
    int? sunset,
    double? windGust,
    double? pop,
    RainEntity? rain,
    Iterable<WeatherEntity> weather = const [],
  }) {
    RealmObjectBase.set(this, 'dt', dt);
    RealmObjectBase.set(this, 'sunrise', sunrise);
    RealmObjectBase.set(this, 'sunset', sunset);
    RealmObjectBase.set(this, 'temp', temp);
    RealmObjectBase.set(this, 'feelsLike', feelsLike);
    RealmObjectBase.set(this, 'pressure', pressure);
    RealmObjectBase.set(this, 'humidity', humidity);
    RealmObjectBase.set(this, 'dewPoint', dewPoint);
    RealmObjectBase.set(this, 'uvi', uvi);
    RealmObjectBase.set(this, 'clouds', clouds);
    RealmObjectBase.set(this, 'visibility', visibility);
    RealmObjectBase.set(this, 'windSpeed', windSpeed);
    RealmObjectBase.set(this, 'windDeg', windDeg);
    RealmObjectBase.set(this, 'windGust', windGust);
    RealmObjectBase.set(this, 'pop', pop);
    RealmObjectBase.set(this, 'rain', rain);
    RealmObjectBase.set<RealmList<WeatherEntity>>(
        this, 'weather', RealmList<WeatherEntity>(weather));
  }

  CurrentEntity._();

  @override
  int get dt => RealmObjectBase.get<int>(this, 'dt') as int;
  @override
  set dt(int value) => RealmObjectBase.set(this, 'dt', value);

  @override
  int? get sunrise => RealmObjectBase.get<int>(this, 'sunrise') as int?;
  @override
  set sunrise(int? value) => RealmObjectBase.set(this, 'sunrise', value);

  @override
  int? get sunset => RealmObjectBase.get<int>(this, 'sunset') as int?;
  @override
  set sunset(int? value) => RealmObjectBase.set(this, 'sunset', value);

  @override
  double get temp => RealmObjectBase.get<double>(this, 'temp') as double;
  @override
  set temp(double value) => RealmObjectBase.set(this, 'temp', value);

  @override
  double get feelsLike =>
      RealmObjectBase.get<double>(this, 'feelsLike') as double;
  @override
  set feelsLike(double value) => RealmObjectBase.set(this, 'feelsLike', value);

  @override
  int get pressure => RealmObjectBase.get<int>(this, 'pressure') as int;
  @override
  set pressure(int value) => RealmObjectBase.set(this, 'pressure', value);

  @override
  int get humidity => RealmObjectBase.get<int>(this, 'humidity') as int;
  @override
  set humidity(int value) => RealmObjectBase.set(this, 'humidity', value);

  @override
  double get dewPoint =>
      RealmObjectBase.get<double>(this, 'dewPoint') as double;
  @override
  set dewPoint(double value) => RealmObjectBase.set(this, 'dewPoint', value);

  @override
  double get uvi => RealmObjectBase.get<double>(this, 'uvi') as double;
  @override
  set uvi(double value) => RealmObjectBase.set(this, 'uvi', value);

  @override
  int get clouds => RealmObjectBase.get<int>(this, 'clouds') as int;
  @override
  set clouds(int value) => RealmObjectBase.set(this, 'clouds', value);

  @override
  int get visibility => RealmObjectBase.get<int>(this, 'visibility') as int;
  @override
  set visibility(int value) => RealmObjectBase.set(this, 'visibility', value);

  @override
  double get windSpeed =>
      RealmObjectBase.get<double>(this, 'windSpeed') as double;
  @override
  set windSpeed(double value) => RealmObjectBase.set(this, 'windSpeed', value);

  @override
  int get windDeg => RealmObjectBase.get<int>(this, 'windDeg') as int;
  @override
  set windDeg(int value) => RealmObjectBase.set(this, 'windDeg', value);

  @override
  double? get windGust =>
      RealmObjectBase.get<double>(this, 'windGust') as double?;
  @override
  set windGust(double? value) => RealmObjectBase.set(this, 'windGust', value);

  @override
  double? get pop => RealmObjectBase.get<double>(this, 'pop') as double?;
  @override
  set pop(double? value) => RealmObjectBase.set(this, 'pop', value);

  @override
  RainEntity? get rain =>
      RealmObjectBase.get<RainEntity>(this, 'rain') as RainEntity?;
  @override
  set rain(covariant RainEntity? value) =>
      RealmObjectBase.set(this, 'rain', value);

  @override
  RealmList<WeatherEntity> get weather =>
      RealmObjectBase.get<WeatherEntity>(this, 'weather')
          as RealmList<WeatherEntity>;
  @override
  set weather(covariant RealmList<WeatherEntity> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<CurrentEntity>> get changes =>
      RealmObjectBase.getChanges<CurrentEntity>(this);

  @override
  Stream<RealmObjectChanges<CurrentEntity>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<CurrentEntity>(this, keyPaths);

  @override
  CurrentEntity freeze() => RealmObjectBase.freezeObject<CurrentEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'dt': dt.toEJson(),
      'sunrise': sunrise.toEJson(),
      'sunset': sunset.toEJson(),
      'temp': temp.toEJson(),
      'feelsLike': feelsLike.toEJson(),
      'pressure': pressure.toEJson(),
      'humidity': humidity.toEJson(),
      'dewPoint': dewPoint.toEJson(),
      'uvi': uvi.toEJson(),
      'clouds': clouds.toEJson(),
      'visibility': visibility.toEJson(),
      'windSpeed': windSpeed.toEJson(),
      'windDeg': windDeg.toEJson(),
      'windGust': windGust.toEJson(),
      'pop': pop.toEJson(),
      'rain': rain.toEJson(),
      'weather': weather.toEJson(),
    };
  }

  static EJsonValue _toEJson(CurrentEntity value) => value.toEJson();
  static CurrentEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'dt': EJsonValue dt,
        'temp': EJsonValue temp,
        'feelsLike': EJsonValue feelsLike,
        'pressure': EJsonValue pressure,
        'humidity': EJsonValue humidity,
        'dewPoint': EJsonValue dewPoint,
        'uvi': EJsonValue uvi,
        'clouds': EJsonValue clouds,
        'visibility': EJsonValue visibility,
        'windSpeed': EJsonValue windSpeed,
        'windDeg': EJsonValue windDeg,
      } =>
        CurrentEntity(
          fromEJson(dt),
          fromEJson(temp),
          fromEJson(feelsLike),
          fromEJson(pressure),
          fromEJson(humidity),
          fromEJson(dewPoint),
          fromEJson(uvi),
          fromEJson(clouds),
          fromEJson(visibility),
          fromEJson(windSpeed),
          fromEJson(windDeg),
          sunrise: fromEJson(ejson['sunrise']),
          sunset: fromEJson(ejson['sunset']),
          windGust: fromEJson(ejson['windGust']),
          pop: fromEJson(ejson['pop']),
          rain: fromEJson(ejson['rain']),
          weather: fromEJson(ejson['weather']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(CurrentEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, CurrentEntity, 'CurrentEntity', [
      SchemaProperty('dt', RealmPropertyType.int),
      SchemaProperty('sunrise', RealmPropertyType.int, optional: true),
      SchemaProperty('sunset', RealmPropertyType.int, optional: true),
      SchemaProperty('temp', RealmPropertyType.double),
      SchemaProperty('feelsLike', RealmPropertyType.double),
      SchemaProperty('pressure', RealmPropertyType.int),
      SchemaProperty('humidity', RealmPropertyType.int),
      SchemaProperty('dewPoint', RealmPropertyType.double),
      SchemaProperty('uvi', RealmPropertyType.double),
      SchemaProperty('clouds', RealmPropertyType.int),
      SchemaProperty('visibility', RealmPropertyType.int),
      SchemaProperty('windSpeed', RealmPropertyType.double),
      SchemaProperty('windDeg', RealmPropertyType.int),
      SchemaProperty('windGust', RealmPropertyType.double, optional: true),
      SchemaProperty('pop', RealmPropertyType.double, optional: true),
      SchemaProperty('rain', RealmPropertyType.object,
          optional: true, linkTarget: 'RainEntity'),
      SchemaProperty('weather', RealmPropertyType.object,
          linkTarget: 'WeatherEntity',
          collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class MinutelyEntity extends _MinutelyEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  MinutelyEntity(
    int dt,
    int precipitation,
  ) {
    RealmObjectBase.set(this, 'dt', dt);
    RealmObjectBase.set(this, 'precipitation', precipitation);
  }

  MinutelyEntity._();

  @override
  int get dt => RealmObjectBase.get<int>(this, 'dt') as int;
  @override
  set dt(int value) => RealmObjectBase.set(this, 'dt', value);

  @override
  int get precipitation =>
      RealmObjectBase.get<int>(this, 'precipitation') as int;
  @override
  set precipitation(int value) =>
      RealmObjectBase.set(this, 'precipitation', value);

  @override
  Stream<RealmObjectChanges<MinutelyEntity>> get changes =>
      RealmObjectBase.getChanges<MinutelyEntity>(this);

  @override
  Stream<RealmObjectChanges<MinutelyEntity>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<MinutelyEntity>(this, keyPaths);

  @override
  MinutelyEntity freeze() => RealmObjectBase.freezeObject<MinutelyEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'dt': dt.toEJson(),
      'precipitation': precipitation.toEJson(),
    };
  }

  static EJsonValue _toEJson(MinutelyEntity value) => value.toEJson();
  static MinutelyEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'dt': EJsonValue dt,
        'precipitation': EJsonValue precipitation,
      } =>
        MinutelyEntity(
          fromEJson(dt),
          fromEJson(precipitation),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(MinutelyEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, MinutelyEntity, 'MinutelyEntity', [
      SchemaProperty('dt', RealmPropertyType.int),
      SchemaProperty('precipitation', RealmPropertyType.int),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class DailyEntity extends _DailyEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  DailyEntity(
    int dt,
    int sunrise,
    int sunset,
    int moonrise,
    int moonset,
    double moonPhase,
    String summary,
    int pressure,
    int humidity,
    double dewPoint,
    double windSpeed,
    int windDeg,
    double windGust,
    int clouds,
    double pop,
    double rain,
    double uvi, {
    TempEntity? temp,
    FeelsLikeEntity? feelsLike,
    Iterable<WeatherEntity> weather = const [],
  }) {
    RealmObjectBase.set(this, 'dt', dt);
    RealmObjectBase.set(this, 'sunrise', sunrise);
    RealmObjectBase.set(this, 'sunset', sunset);
    RealmObjectBase.set(this, 'moonrise', moonrise);
    RealmObjectBase.set(this, 'moonset', moonset);
    RealmObjectBase.set(this, 'moonPhase', moonPhase);
    RealmObjectBase.set(this, 'summary', summary);
    RealmObjectBase.set(this, 'temp', temp);
    RealmObjectBase.set(this, 'feelsLike', feelsLike);
    RealmObjectBase.set(this, 'pressure', pressure);
    RealmObjectBase.set(this, 'humidity', humidity);
    RealmObjectBase.set(this, 'dewPoint', dewPoint);
    RealmObjectBase.set(this, 'windSpeed', windSpeed);
    RealmObjectBase.set(this, 'windDeg', windDeg);
    RealmObjectBase.set(this, 'windGust', windGust);
    RealmObjectBase.set(this, 'clouds', clouds);
    RealmObjectBase.set(this, 'pop', pop);
    RealmObjectBase.set(this, 'rain', rain);
    RealmObjectBase.set(this, 'uvi', uvi);
    RealmObjectBase.set<RealmList<WeatherEntity>>(
        this, 'weather', RealmList<WeatherEntity>(weather));
  }

  DailyEntity._();

  @override
  int get dt => RealmObjectBase.get<int>(this, 'dt') as int;
  @override
  set dt(int value) => RealmObjectBase.set(this, 'dt', value);

  @override
  int get sunrise => RealmObjectBase.get<int>(this, 'sunrise') as int;
  @override
  set sunrise(int value) => RealmObjectBase.set(this, 'sunrise', value);

  @override
  int get sunset => RealmObjectBase.get<int>(this, 'sunset') as int;
  @override
  set sunset(int value) => RealmObjectBase.set(this, 'sunset', value);

  @override
  int get moonrise => RealmObjectBase.get<int>(this, 'moonrise') as int;
  @override
  set moonrise(int value) => RealmObjectBase.set(this, 'moonrise', value);

  @override
  int get moonset => RealmObjectBase.get<int>(this, 'moonset') as int;
  @override
  set moonset(int value) => RealmObjectBase.set(this, 'moonset', value);

  @override
  double get moonPhase =>
      RealmObjectBase.get<double>(this, 'moonPhase') as double;
  @override
  set moonPhase(double value) => RealmObjectBase.set(this, 'moonPhase', value);

  @override
  String get summary => RealmObjectBase.get<String>(this, 'summary') as String;
  @override
  set summary(String value) => RealmObjectBase.set(this, 'summary', value);

  @override
  TempEntity? get temp =>
      RealmObjectBase.get<TempEntity>(this, 'temp') as TempEntity?;
  @override
  set temp(covariant TempEntity? value) =>
      RealmObjectBase.set(this, 'temp', value);

  @override
  FeelsLikeEntity? get feelsLike =>
      RealmObjectBase.get<FeelsLikeEntity>(this, 'feelsLike')
          as FeelsLikeEntity?;
  @override
  set feelsLike(covariant FeelsLikeEntity? value) =>
      RealmObjectBase.set(this, 'feelsLike', value);

  @override
  int get pressure => RealmObjectBase.get<int>(this, 'pressure') as int;
  @override
  set pressure(int value) => RealmObjectBase.set(this, 'pressure', value);

  @override
  int get humidity => RealmObjectBase.get<int>(this, 'humidity') as int;
  @override
  set humidity(int value) => RealmObjectBase.set(this, 'humidity', value);

  @override
  double get dewPoint =>
      RealmObjectBase.get<double>(this, 'dewPoint') as double;
  @override
  set dewPoint(double value) => RealmObjectBase.set(this, 'dewPoint', value);

  @override
  double get windSpeed =>
      RealmObjectBase.get<double>(this, 'windSpeed') as double;
  @override
  set windSpeed(double value) => RealmObjectBase.set(this, 'windSpeed', value);

  @override
  int get windDeg => RealmObjectBase.get<int>(this, 'windDeg') as int;
  @override
  set windDeg(int value) => RealmObjectBase.set(this, 'windDeg', value);

  @override
  double get windGust =>
      RealmObjectBase.get<double>(this, 'windGust') as double;
  @override
  set windGust(double value) => RealmObjectBase.set(this, 'windGust', value);

  @override
  int get clouds => RealmObjectBase.get<int>(this, 'clouds') as int;
  @override
  set clouds(int value) => RealmObjectBase.set(this, 'clouds', value);

  @override
  double get pop => RealmObjectBase.get<double>(this, 'pop') as double;
  @override
  set pop(double value) => RealmObjectBase.set(this, 'pop', value);

  @override
  double get rain => RealmObjectBase.get<double>(this, 'rain') as double;
  @override
  set rain(double value) => RealmObjectBase.set(this, 'rain', value);

  @override
  double get uvi => RealmObjectBase.get<double>(this, 'uvi') as double;
  @override
  set uvi(double value) => RealmObjectBase.set(this, 'uvi', value);

  @override
  RealmList<WeatherEntity> get weather =>
      RealmObjectBase.get<WeatherEntity>(this, 'weather')
          as RealmList<WeatherEntity>;
  @override
  set weather(covariant RealmList<WeatherEntity> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<DailyEntity>> get changes =>
      RealmObjectBase.getChanges<DailyEntity>(this);

  @override
  Stream<RealmObjectChanges<DailyEntity>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<DailyEntity>(this, keyPaths);

  @override
  DailyEntity freeze() => RealmObjectBase.freezeObject<DailyEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'dt': dt.toEJson(),
      'sunrise': sunrise.toEJson(),
      'sunset': sunset.toEJson(),
      'moonrise': moonrise.toEJson(),
      'moonset': moonset.toEJson(),
      'moonPhase': moonPhase.toEJson(),
      'summary': summary.toEJson(),
      'temp': temp.toEJson(),
      'feelsLike': feelsLike.toEJson(),
      'pressure': pressure.toEJson(),
      'humidity': humidity.toEJson(),
      'dewPoint': dewPoint.toEJson(),
      'windSpeed': windSpeed.toEJson(),
      'windDeg': windDeg.toEJson(),
      'windGust': windGust.toEJson(),
      'clouds': clouds.toEJson(),
      'pop': pop.toEJson(),
      'rain': rain.toEJson(),
      'uvi': uvi.toEJson(),
      'weather': weather.toEJson(),
    };
  }

  static EJsonValue _toEJson(DailyEntity value) => value.toEJson();
  static DailyEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'dt': EJsonValue dt,
        'sunrise': EJsonValue sunrise,
        'sunset': EJsonValue sunset,
        'moonrise': EJsonValue moonrise,
        'moonset': EJsonValue moonset,
        'moonPhase': EJsonValue moonPhase,
        'summary': EJsonValue summary,
        'pressure': EJsonValue pressure,
        'humidity': EJsonValue humidity,
        'dewPoint': EJsonValue dewPoint,
        'windSpeed': EJsonValue windSpeed,
        'windDeg': EJsonValue windDeg,
        'windGust': EJsonValue windGust,
        'clouds': EJsonValue clouds,
        'pop': EJsonValue pop,
        'rain': EJsonValue rain,
        'uvi': EJsonValue uvi,
      } =>
        DailyEntity(
          fromEJson(dt),
          fromEJson(sunrise),
          fromEJson(sunset),
          fromEJson(moonrise),
          fromEJson(moonset),
          fromEJson(moonPhase),
          fromEJson(summary),
          fromEJson(pressure),
          fromEJson(humidity),
          fromEJson(dewPoint),
          fromEJson(windSpeed),
          fromEJson(windDeg),
          fromEJson(windGust),
          fromEJson(clouds),
          fromEJson(pop),
          fromEJson(rain),
          fromEJson(uvi),
          temp: fromEJson(ejson['temp']),
          feelsLike: fromEJson(ejson['feelsLike']),
          weather: fromEJson(ejson['weather']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(DailyEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, DailyEntity, 'DailyEntity', [
      SchemaProperty('dt', RealmPropertyType.int),
      SchemaProperty('sunrise', RealmPropertyType.int),
      SchemaProperty('sunset', RealmPropertyType.int),
      SchemaProperty('moonrise', RealmPropertyType.int),
      SchemaProperty('moonset', RealmPropertyType.int),
      SchemaProperty('moonPhase', RealmPropertyType.double),
      SchemaProperty('summary', RealmPropertyType.string),
      SchemaProperty('temp', RealmPropertyType.object,
          optional: true, linkTarget: 'TempEntity'),
      SchemaProperty('feelsLike', RealmPropertyType.object,
          optional: true, linkTarget: 'FeelsLikeEntity'),
      SchemaProperty('pressure', RealmPropertyType.int),
      SchemaProperty('humidity', RealmPropertyType.int),
      SchemaProperty('dewPoint', RealmPropertyType.double),
      SchemaProperty('windSpeed', RealmPropertyType.double),
      SchemaProperty('windDeg', RealmPropertyType.int),
      SchemaProperty('windGust', RealmPropertyType.double),
      SchemaProperty('clouds', RealmPropertyType.int),
      SchemaProperty('pop', RealmPropertyType.double),
      SchemaProperty('rain', RealmPropertyType.double),
      SchemaProperty('uvi', RealmPropertyType.double),
      SchemaProperty('weather', RealmPropertyType.object,
          linkTarget: 'WeatherEntity',
          collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class WeatherEntity extends _WeatherEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  WeatherEntity(
    int id,
    String main,
    String description,
    String icon,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'main', main);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'icon', icon);
  }

  WeatherEntity._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get main => RealmObjectBase.get<String>(this, 'main') as String;
  @override
  set main(String value) => RealmObjectBase.set(this, 'main', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  String get icon => RealmObjectBase.get<String>(this, 'icon') as String;
  @override
  set icon(String value) => RealmObjectBase.set(this, 'icon', value);

  @override
  Stream<RealmObjectChanges<WeatherEntity>> get changes =>
      RealmObjectBase.getChanges<WeatherEntity>(this);

  @override
  Stream<RealmObjectChanges<WeatherEntity>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<WeatherEntity>(this, keyPaths);

  @override
  WeatherEntity freeze() => RealmObjectBase.freezeObject<WeatherEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'main': main.toEJson(),
      'description': description.toEJson(),
      'icon': icon.toEJson(),
    };
  }

  static EJsonValue _toEJson(WeatherEntity value) => value.toEJson();
  static WeatherEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'main': EJsonValue main,
        'description': EJsonValue description,
        'icon': EJsonValue icon,
      } =>
        WeatherEntity(
          fromEJson(id),
          fromEJson(main),
          fromEJson(description),
          fromEJson(icon),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(WeatherEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, WeatherEntity, 'WeatherEntity', [
      SchemaProperty('id', RealmPropertyType.int),
      SchemaProperty('main', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('icon', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class TempEntity extends _TempEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  TempEntity(
    double day,
    double min,
    double max,
    double night,
    double eve,
    double morn,
  ) {
    RealmObjectBase.set(this, 'day', day);
    RealmObjectBase.set(this, 'min', min);
    RealmObjectBase.set(this, 'max', max);
    RealmObjectBase.set(this, 'night', night);
    RealmObjectBase.set(this, 'eve', eve);
    RealmObjectBase.set(this, 'morn', morn);
  }

  TempEntity._();

  @override
  double get day => RealmObjectBase.get<double>(this, 'day') as double;
  @override
  set day(double value) => RealmObjectBase.set(this, 'day', value);

  @override
  double get min => RealmObjectBase.get<double>(this, 'min') as double;
  @override
  set min(double value) => RealmObjectBase.set(this, 'min', value);

  @override
  double get max => RealmObjectBase.get<double>(this, 'max') as double;
  @override
  set max(double value) => RealmObjectBase.set(this, 'max', value);

  @override
  double get night => RealmObjectBase.get<double>(this, 'night') as double;
  @override
  set night(double value) => RealmObjectBase.set(this, 'night', value);

  @override
  double get eve => RealmObjectBase.get<double>(this, 'eve') as double;
  @override
  set eve(double value) => RealmObjectBase.set(this, 'eve', value);

  @override
  double get morn => RealmObjectBase.get<double>(this, 'morn') as double;
  @override
  set morn(double value) => RealmObjectBase.set(this, 'morn', value);

  @override
  Stream<RealmObjectChanges<TempEntity>> get changes =>
      RealmObjectBase.getChanges<TempEntity>(this);

  @override
  Stream<RealmObjectChanges<TempEntity>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<TempEntity>(this, keyPaths);

  @override
  TempEntity freeze() => RealmObjectBase.freezeObject<TempEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'day': day.toEJson(),
      'min': min.toEJson(),
      'max': max.toEJson(),
      'night': night.toEJson(),
      'eve': eve.toEJson(),
      'morn': morn.toEJson(),
    };
  }

  static EJsonValue _toEJson(TempEntity value) => value.toEJson();
  static TempEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'day': EJsonValue day,
        'min': EJsonValue min,
        'max': EJsonValue max,
        'night': EJsonValue night,
        'eve': EJsonValue eve,
        'morn': EJsonValue morn,
      } =>
        TempEntity(
          fromEJson(day),
          fromEJson(min),
          fromEJson(max),
          fromEJson(night),
          fromEJson(eve),
          fromEJson(morn),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(TempEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, TempEntity, 'TempEntity', [
      SchemaProperty('day', RealmPropertyType.double),
      SchemaProperty('min', RealmPropertyType.double),
      SchemaProperty('max', RealmPropertyType.double),
      SchemaProperty('night', RealmPropertyType.double),
      SchemaProperty('eve', RealmPropertyType.double),
      SchemaProperty('morn', RealmPropertyType.double),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class FeelsLikeEntity extends _FeelsLikeEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  FeelsLikeEntity(
    double day,
    double night,
    double eve,
    double morn,
  ) {
    RealmObjectBase.set(this, 'day', day);
    RealmObjectBase.set(this, 'night', night);
    RealmObjectBase.set(this, 'eve', eve);
    RealmObjectBase.set(this, 'morn', morn);
  }

  FeelsLikeEntity._();

  @override
  double get day => RealmObjectBase.get<double>(this, 'day') as double;
  @override
  set day(double value) => RealmObjectBase.set(this, 'day', value);

  @override
  double get night => RealmObjectBase.get<double>(this, 'night') as double;
  @override
  set night(double value) => RealmObjectBase.set(this, 'night', value);

  @override
  double get eve => RealmObjectBase.get<double>(this, 'eve') as double;
  @override
  set eve(double value) => RealmObjectBase.set(this, 'eve', value);

  @override
  double get morn => RealmObjectBase.get<double>(this, 'morn') as double;
  @override
  set morn(double value) => RealmObjectBase.set(this, 'morn', value);

  @override
  Stream<RealmObjectChanges<FeelsLikeEntity>> get changes =>
      RealmObjectBase.getChanges<FeelsLikeEntity>(this);

  @override
  Stream<RealmObjectChanges<FeelsLikeEntity>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<FeelsLikeEntity>(this, keyPaths);

  @override
  FeelsLikeEntity freeze() =>
      RealmObjectBase.freezeObject<FeelsLikeEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'day': day.toEJson(),
      'night': night.toEJson(),
      'eve': eve.toEJson(),
      'morn': morn.toEJson(),
    };
  }

  static EJsonValue _toEJson(FeelsLikeEntity value) => value.toEJson();
  static FeelsLikeEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'day': EJsonValue day,
        'night': EJsonValue night,
        'eve': EJsonValue eve,
        'morn': EJsonValue morn,
      } =>
        FeelsLikeEntity(
          fromEJson(day),
          fromEJson(night),
          fromEJson(eve),
          fromEJson(morn),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(FeelsLikeEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, FeelsLikeEntity, 'FeelsLikeEntity', [
      SchemaProperty('day', RealmPropertyType.double),
      SchemaProperty('night', RealmPropertyType.double),
      SchemaProperty('eve', RealmPropertyType.double),
      SchemaProperty('morn', RealmPropertyType.double),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class RainEntity extends _RainEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  RainEntity(
    double the1H,
  ) {
    RealmObjectBase.set(this, 'the1H', the1H);
  }

  RainEntity._();

  @override
  double get the1H => RealmObjectBase.get<double>(this, 'the1H') as double;
  @override
  set the1H(double value) => RealmObjectBase.set(this, 'the1H', value);

  @override
  Stream<RealmObjectChanges<RainEntity>> get changes =>
      RealmObjectBase.getChanges<RainEntity>(this);

  @override
  Stream<RealmObjectChanges<RainEntity>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RainEntity>(this, keyPaths);

  @override
  RainEntity freeze() => RealmObjectBase.freezeObject<RainEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'the1H': the1H.toEJson(),
    };
  }

  static EJsonValue _toEJson(RainEntity value) => value.toEJson();
  static RainEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'the1H': EJsonValue the1H,
      } =>
        RainEntity(
          fromEJson(the1H),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RainEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, RainEntity, 'RainEntity', [
      SchemaProperty('the1H', RealmPropertyType.double),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
