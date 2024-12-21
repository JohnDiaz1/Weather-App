// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_aggregation_entity.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class DailyAggregationEntity extends _DailyAggregationEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  DailyAggregationEntity(
    String id,
    double lat,
    double lon,
    String tz,
    DateTime date,
    String units, {
    CloudCoverEntity? cloudCover,
    CloudCoverEntity? humidity,
    PrecipitationEntity? precipitation,
    TemperatureEntity? temperature,
    CloudCoverEntity? pressure,
    WindEntity? wind,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'lat', lat);
    RealmObjectBase.set(this, 'lon', lon);
    RealmObjectBase.set(this, 'tz', tz);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'units', units);
    RealmObjectBase.set(this, 'cloudCover', cloudCover);
    RealmObjectBase.set(this, 'humidity', humidity);
    RealmObjectBase.set(this, 'precipitation', precipitation);
    RealmObjectBase.set(this, 'temperature', temperature);
    RealmObjectBase.set(this, 'pressure', pressure);
    RealmObjectBase.set(this, 'wind', wind);
  }

  DailyAggregationEntity._();

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
  String get tz => RealmObjectBase.get<String>(this, 'tz') as String;
  @override
  set tz(String value) => RealmObjectBase.set(this, 'tz', value);

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => RealmObjectBase.set(this, 'date', value);

  @override
  String get units => RealmObjectBase.get<String>(this, 'units') as String;
  @override
  set units(String value) => RealmObjectBase.set(this, 'units', value);

  @override
  CloudCoverEntity? get cloudCover =>
      RealmObjectBase.get<CloudCoverEntity>(this, 'cloudCover')
          as CloudCoverEntity?;
  @override
  set cloudCover(covariant CloudCoverEntity? value) =>
      RealmObjectBase.set(this, 'cloudCover', value);

  @override
  CloudCoverEntity? get humidity =>
      RealmObjectBase.get<CloudCoverEntity>(this, 'humidity')
          as CloudCoverEntity?;
  @override
  set humidity(covariant CloudCoverEntity? value) =>
      RealmObjectBase.set(this, 'humidity', value);

  @override
  PrecipitationEntity? get precipitation =>
      RealmObjectBase.get<PrecipitationEntity>(this, 'precipitation')
          as PrecipitationEntity?;
  @override
  set precipitation(covariant PrecipitationEntity? value) =>
      RealmObjectBase.set(this, 'precipitation', value);

  @override
  TemperatureEntity? get temperature =>
      RealmObjectBase.get<TemperatureEntity>(this, 'temperature')
          as TemperatureEntity?;
  @override
  set temperature(covariant TemperatureEntity? value) =>
      RealmObjectBase.set(this, 'temperature', value);

  @override
  CloudCoverEntity? get pressure =>
      RealmObjectBase.get<CloudCoverEntity>(this, 'pressure')
          as CloudCoverEntity?;
  @override
  set pressure(covariant CloudCoverEntity? value) =>
      RealmObjectBase.set(this, 'pressure', value);

  @override
  WindEntity? get wind =>
      RealmObjectBase.get<WindEntity>(this, 'wind') as WindEntity?;
  @override
  set wind(covariant WindEntity? value) =>
      RealmObjectBase.set(this, 'wind', value);

  @override
  Stream<RealmObjectChanges<DailyAggregationEntity>> get changes =>
      RealmObjectBase.getChanges<DailyAggregationEntity>(this);

  @override
  Stream<RealmObjectChanges<DailyAggregationEntity>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<DailyAggregationEntity>(this, keyPaths);

  @override
  DailyAggregationEntity freeze() =>
      RealmObjectBase.freezeObject<DailyAggregationEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'lat': lat.toEJson(),
      'lon': lon.toEJson(),
      'tz': tz.toEJson(),
      'date': date.toEJson(),
      'units': units.toEJson(),
      'cloudCover': cloudCover.toEJson(),
      'humidity': humidity.toEJson(),
      'precipitation': precipitation.toEJson(),
      'temperature': temperature.toEJson(),
      'pressure': pressure.toEJson(),
      'wind': wind.toEJson(),
    };
  }

  static EJsonValue _toEJson(DailyAggregationEntity value) => value.toEJson();
  static DailyAggregationEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'lat': EJsonValue lat,
        'lon': EJsonValue lon,
        'tz': EJsonValue tz,
        'date': EJsonValue date,
        'units': EJsonValue units,
      } =>
        DailyAggregationEntity(
          fromEJson(id),
          fromEJson(lat),
          fromEJson(lon),
          fromEJson(tz),
          fromEJson(date),
          fromEJson(units),
          cloudCover: fromEJson(ejson['cloudCover']),
          humidity: fromEJson(ejson['humidity']),
          precipitation: fromEJson(ejson['precipitation']),
          temperature: fromEJson(ejson['temperature']),
          pressure: fromEJson(ejson['pressure']),
          wind: fromEJson(ejson['wind']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(DailyAggregationEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, DailyAggregationEntity,
        'DailyAggregationEntity', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('lat', RealmPropertyType.double),
      SchemaProperty('lon', RealmPropertyType.double),
      SchemaProperty('tz', RealmPropertyType.string),
      SchemaProperty('date', RealmPropertyType.timestamp),
      SchemaProperty('units', RealmPropertyType.string),
      SchemaProperty('cloudCover', RealmPropertyType.object,
          optional: true, linkTarget: 'CloudCoverEntity'),
      SchemaProperty('humidity', RealmPropertyType.object,
          optional: true, linkTarget: 'CloudCoverEntity'),
      SchemaProperty('precipitation', RealmPropertyType.object,
          optional: true, linkTarget: 'PrecipitationEntity'),
      SchemaProperty('temperature', RealmPropertyType.object,
          optional: true, linkTarget: 'TemperatureEntity'),
      SchemaProperty('pressure', RealmPropertyType.object,
          optional: true, linkTarget: 'CloudCoverEntity'),
      SchemaProperty('wind', RealmPropertyType.object,
          optional: true, linkTarget: 'WindEntity'),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class CloudCoverEntity extends _CloudCoverEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  CloudCoverEntity(
    double afternoon,
  ) {
    RealmObjectBase.set(this, 'afternoon', afternoon);
  }

  CloudCoverEntity._();

  @override
  double get afternoon =>
      RealmObjectBase.get<double>(this, 'afternoon') as double;
  @override
  set afternoon(double value) => RealmObjectBase.set(this, 'afternoon', value);

  @override
  Stream<RealmObjectChanges<CloudCoverEntity>> get changes =>
      RealmObjectBase.getChanges<CloudCoverEntity>(this);

  @override
  Stream<RealmObjectChanges<CloudCoverEntity>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<CloudCoverEntity>(this, keyPaths);

  @override
  CloudCoverEntity freeze() =>
      RealmObjectBase.freezeObject<CloudCoverEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'afternoon': afternoon.toEJson(),
    };
  }

  static EJsonValue _toEJson(CloudCoverEntity value) => value.toEJson();
  static CloudCoverEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'afternoon': EJsonValue afternoon,
      } =>
        CloudCoverEntity(
          fromEJson(afternoon),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(CloudCoverEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, CloudCoverEntity, 'CloudCoverEntity', [
      SchemaProperty('afternoon', RealmPropertyType.double),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class PrecipitationEntity extends _PrecipitationEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  PrecipitationEntity(
    double total,
  ) {
    RealmObjectBase.set(this, 'total', total);
  }

  PrecipitationEntity._();

  @override
  double get total => RealmObjectBase.get<double>(this, 'total') as double;
  @override
  set total(double value) => RealmObjectBase.set(this, 'total', value);

  @override
  Stream<RealmObjectChanges<PrecipitationEntity>> get changes =>
      RealmObjectBase.getChanges<PrecipitationEntity>(this);

  @override
  Stream<RealmObjectChanges<PrecipitationEntity>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<PrecipitationEntity>(this, keyPaths);

  @override
  PrecipitationEntity freeze() =>
      RealmObjectBase.freezeObject<PrecipitationEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'total': total.toEJson(),
    };
  }

  static EJsonValue _toEJson(PrecipitationEntity value) => value.toEJson();
  static PrecipitationEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'total': EJsonValue total,
      } =>
        PrecipitationEntity(
          fromEJson(total),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(PrecipitationEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, PrecipitationEntity, 'PrecipitationEntity', [
      SchemaProperty('total', RealmPropertyType.double),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class TemperatureEntity extends _TemperatureEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  TemperatureEntity(
    double min,
    double max,
    double afternoon,
    double night,
    double evening,
    double morning,
  ) {
    RealmObjectBase.set(this, 'min', min);
    RealmObjectBase.set(this, 'max', max);
    RealmObjectBase.set(this, 'afternoon', afternoon);
    RealmObjectBase.set(this, 'night', night);
    RealmObjectBase.set(this, 'evening', evening);
    RealmObjectBase.set(this, 'morning', morning);
  }

  TemperatureEntity._();

  @override
  double get min => RealmObjectBase.get<double>(this, 'min') as double;
  @override
  set min(double value) => RealmObjectBase.set(this, 'min', value);

  @override
  double get max => RealmObjectBase.get<double>(this, 'max') as double;
  @override
  set max(double value) => RealmObjectBase.set(this, 'max', value);

  @override
  double get afternoon =>
      RealmObjectBase.get<double>(this, 'afternoon') as double;
  @override
  set afternoon(double value) => RealmObjectBase.set(this, 'afternoon', value);

  @override
  double get night => RealmObjectBase.get<double>(this, 'night') as double;
  @override
  set night(double value) => RealmObjectBase.set(this, 'night', value);

  @override
  double get evening => RealmObjectBase.get<double>(this, 'evening') as double;
  @override
  set evening(double value) => RealmObjectBase.set(this, 'evening', value);

  @override
  double get morning => RealmObjectBase.get<double>(this, 'morning') as double;
  @override
  set morning(double value) => RealmObjectBase.set(this, 'morning', value);

  @override
  Stream<RealmObjectChanges<TemperatureEntity>> get changes =>
      RealmObjectBase.getChanges<TemperatureEntity>(this);

  @override
  Stream<RealmObjectChanges<TemperatureEntity>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<TemperatureEntity>(this, keyPaths);

  @override
  TemperatureEntity freeze() =>
      RealmObjectBase.freezeObject<TemperatureEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'min': min.toEJson(),
      'max': max.toEJson(),
      'afternoon': afternoon.toEJson(),
      'night': night.toEJson(),
      'evening': evening.toEJson(),
      'morning': morning.toEJson(),
    };
  }

  static EJsonValue _toEJson(TemperatureEntity value) => value.toEJson();
  static TemperatureEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'min': EJsonValue min,
        'max': EJsonValue max,
        'afternoon': EJsonValue afternoon,
        'night': EJsonValue night,
        'evening': EJsonValue evening,
        'morning': EJsonValue morning,
      } =>
        TemperatureEntity(
          fromEJson(min),
          fromEJson(max),
          fromEJson(afternoon),
          fromEJson(night),
          fromEJson(evening),
          fromEJson(morning),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(TemperatureEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, TemperatureEntity, 'TemperatureEntity', [
      SchemaProperty('min', RealmPropertyType.double),
      SchemaProperty('max', RealmPropertyType.double),
      SchemaProperty('afternoon', RealmPropertyType.double),
      SchemaProperty('night', RealmPropertyType.double),
      SchemaProperty('evening', RealmPropertyType.double),
      SchemaProperty('morning', RealmPropertyType.double),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class WindEntity extends _WindEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  WindEntity({
    MaxEntity? max,
  }) {
    RealmObjectBase.set(this, 'max', max);
  }

  WindEntity._();

  @override
  MaxEntity? get max =>
      RealmObjectBase.get<MaxEntity>(this, 'max') as MaxEntity?;
  @override
  set max(covariant MaxEntity? value) =>
      RealmObjectBase.set(this, 'max', value);

  @override
  Stream<RealmObjectChanges<WindEntity>> get changes =>
      RealmObjectBase.getChanges<WindEntity>(this);

  @override
  Stream<RealmObjectChanges<WindEntity>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<WindEntity>(this, keyPaths);

  @override
  WindEntity freeze() => RealmObjectBase.freezeObject<WindEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'max': max.toEJson(),
    };
  }

  static EJsonValue _toEJson(WindEntity value) => value.toEJson();
  static WindEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return WindEntity(
      max: fromEJson(ejson['max']),
    );
  }

  static final schema = () {
    RealmObjectBase.registerFactory(WindEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, WindEntity, 'WindEntity', [
      SchemaProperty('max', RealmPropertyType.object,
          optional: true, linkTarget: 'MaxEntity'),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class MaxEntity extends _MaxEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  MaxEntity(
    double speed,
    double direction,
  ) {
    RealmObjectBase.set(this, 'speed', speed);
    RealmObjectBase.set(this, 'direction', direction);
  }

  MaxEntity._();

  @override
  double get speed => RealmObjectBase.get<double>(this, 'speed') as double;
  @override
  set speed(double value) => RealmObjectBase.set(this, 'speed', value);

  @override
  double get direction =>
      RealmObjectBase.get<double>(this, 'direction') as double;
  @override
  set direction(double value) => RealmObjectBase.set(this, 'direction', value);

  @override
  Stream<RealmObjectChanges<MaxEntity>> get changes =>
      RealmObjectBase.getChanges<MaxEntity>(this);

  @override
  Stream<RealmObjectChanges<MaxEntity>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<MaxEntity>(this, keyPaths);

  @override
  MaxEntity freeze() => RealmObjectBase.freezeObject<MaxEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'speed': speed.toEJson(),
      'direction': direction.toEJson(),
    };
  }

  static EJsonValue _toEJson(MaxEntity value) => value.toEJson();
  static MaxEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'speed': EJsonValue speed,
        'direction': EJsonValue direction,
      } =>
        MaxEntity(
          fromEJson(speed),
          fromEJson(direction),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(MaxEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, MaxEntity, 'MaxEntity', [
      SchemaProperty('speed', RealmPropertyType.double),
      SchemaProperty('direction', RealmPropertyType.double),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
