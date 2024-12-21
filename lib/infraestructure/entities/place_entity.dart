import 'package:realm/realm.dart';
part 'place_entity.realm.dart';

@RealmModel()
class _PlaceEntity {

  @PrimaryKey()
  late int  placeId;

  late String osmType;
  late int osmId;
  late double lat;
  late double lon;
  late String displayName;
  late int placeRank;
  late String category;
  late String type;
  late double  importance;
}