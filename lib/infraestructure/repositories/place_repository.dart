import 'package:realm/realm.dart';
import '../../config/db/realm_config.dart';
import '../entities/place_entity.dart';

class PlaceRepository {
  final Realm realm;

  PlaceRepository() : realm = RealmConfig.realm;

  /// Returns a Stream of PlaceEntity lists that updates whenever the data changes
  Stream<List<PlaceEntity>> getAllPlacesStream() {
    // Get the RealmResults for all PlaceEntity objects
    final results = realm.all<PlaceEntity>();

    // Create a stream that maps the changes to detached copies
    return results.changes.map((change) {
      return change.results.map((place) => _detachFromRealm(place)).toList();
    });
  }

  PlaceEntity _detachFromRealm(PlaceEntity original) {
    return PlaceEntity(
      original.placeId,
      original.osmType,
      original.osmId,
      original.lat,
      original.lon,
      original.displayName,
      original.placeRank,
      original.category,
      original.type,
      original.importance,
    );
  }

  /// Saves or updates a Place and returns true if successful
  Future<bool> savePlace(PlaceEntity place) async {
    try {
      realm.write(() {
        realm.add(place, update: true);
      });
      return true;
    } catch (e) {
      print('Error saving place: $e');
      return false;
    }
  }

  Future<bool> deletePlace(int placeId) async {
    try {
      realm.write(() {
        final item = realm.find<PlaceEntity>(placeId);
        if (item != null) {
          // Store necessary data before deletion
          final displayName = item.displayName;

          // Perform the deletion
          realm.delete(item);
        }
      });
      return true;
    } catch (e) {
      print('Error deleting place: $e');
      return false;
    }
  }

  /// Clears all Places and returns true if successful
  Future<bool> clearAllPlaces() async {
    try {
      realm.write(() {
        realm.deleteAll<PlaceEntity>();
      });
      return true;
    } catch (e) {
      print('Error clearing places: $e');
      return false;
    }
  }

  /// Gets all Places as a List (non-reactive)
  List<PlaceEntity> getAllPlaces() {
    return realm.all<PlaceEntity>().toList();
  }
}