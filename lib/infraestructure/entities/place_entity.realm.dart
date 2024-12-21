// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_entity.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class PlaceEntity extends _PlaceEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  PlaceEntity(
    int placeId,
    String osmType,
    int osmId,
    double lat,
    double lon,
    String displayName,
    int placeRank,
    String category,
    String type,
    double importance,
  ) {
    RealmObjectBase.set(this, 'placeId', placeId);
    RealmObjectBase.set(this, 'osmType', osmType);
    RealmObjectBase.set(this, 'osmId', osmId);
    RealmObjectBase.set(this, 'lat', lat);
    RealmObjectBase.set(this, 'lon', lon);
    RealmObjectBase.set(this, 'displayName', displayName);
    RealmObjectBase.set(this, 'placeRank', placeRank);
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'type', type);
    RealmObjectBase.set(this, 'importance', importance);
  }

  PlaceEntity._();

  @override
  int get placeId => RealmObjectBase.get<int>(this, 'placeId') as int;
  @override
  set placeId(int value) => RealmObjectBase.set(this, 'placeId', value);

  @override
  String get osmType => RealmObjectBase.get<String>(this, 'osmType') as String;
  @override
  set osmType(String value) => RealmObjectBase.set(this, 'osmType', value);

  @override
  int get osmId => RealmObjectBase.get<int>(this, 'osmId') as int;
  @override
  set osmId(int value) => RealmObjectBase.set(this, 'osmId', value);

  @override
  double get lat => RealmObjectBase.get<double>(this, 'lat') as double;
  @override
  set lat(double value) => RealmObjectBase.set(this, 'lat', value);

  @override
  double get lon => RealmObjectBase.get<double>(this, 'lon') as double;
  @override
  set lon(double value) => RealmObjectBase.set(this, 'lon', value);

  @override
  String get displayName =>
      RealmObjectBase.get<String>(this, 'displayName') as String;
  @override
  set displayName(String value) =>
      RealmObjectBase.set(this, 'displayName', value);

  @override
  int get placeRank => RealmObjectBase.get<int>(this, 'placeRank') as int;
  @override
  set placeRank(int value) => RealmObjectBase.set(this, 'placeRank', value);

  @override
  String get category =>
      RealmObjectBase.get<String>(this, 'category') as String;
  @override
  set category(String value) => RealmObjectBase.set(this, 'category', value);

  @override
  String get type => RealmObjectBase.get<String>(this, 'type') as String;
  @override
  set type(String value) => RealmObjectBase.set(this, 'type', value);

  @override
  double get importance =>
      RealmObjectBase.get<double>(this, 'importance') as double;
  @override
  set importance(double value) =>
      RealmObjectBase.set(this, 'importance', value);

  @override
  Stream<RealmObjectChanges<PlaceEntity>> get changes =>
      RealmObjectBase.getChanges<PlaceEntity>(this);

  @override
  Stream<RealmObjectChanges<PlaceEntity>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<PlaceEntity>(this, keyPaths);

  @override
  PlaceEntity freeze() => RealmObjectBase.freezeObject<PlaceEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'placeId': placeId.toEJson(),
      'osmType': osmType.toEJson(),
      'osmId': osmId.toEJson(),
      'lat': lat.toEJson(),
      'lon': lon.toEJson(),
      'displayName': displayName.toEJson(),
      'placeRank': placeRank.toEJson(),
      'category': category.toEJson(),
      'type': type.toEJson(),
      'importance': importance.toEJson(),
    };
  }

  static EJsonValue _toEJson(PlaceEntity value) => value.toEJson();
  static PlaceEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'placeId': EJsonValue placeId,
        'osmType': EJsonValue osmType,
        'osmId': EJsonValue osmId,
        'lat': EJsonValue lat,
        'lon': EJsonValue lon,
        'displayName': EJsonValue displayName,
        'placeRank': EJsonValue placeRank,
        'category': EJsonValue category,
        'type': EJsonValue type,
        'importance': EJsonValue importance,
      } =>
        PlaceEntity(
          fromEJson(placeId),
          fromEJson(osmType),
          fromEJson(osmId),
          fromEJson(lat),
          fromEJson(lon),
          fromEJson(displayName),
          fromEJson(placeRank),
          fromEJson(category),
          fromEJson(type),
          fromEJson(importance),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(PlaceEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, PlaceEntity, 'PlaceEntity', [
      SchemaProperty('placeId', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('osmType', RealmPropertyType.string),
      SchemaProperty('osmId', RealmPropertyType.int),
      SchemaProperty('lat', RealmPropertyType.double),
      SchemaProperty('lon', RealmPropertyType.double),
      SchemaProperty('displayName', RealmPropertyType.string),
      SchemaProperty('placeRank', RealmPropertyType.int),
      SchemaProperty('category', RealmPropertyType.string),
      SchemaProperty('type', RealmPropertyType.string),
      SchemaProperty('importance', RealmPropertyType.double),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
