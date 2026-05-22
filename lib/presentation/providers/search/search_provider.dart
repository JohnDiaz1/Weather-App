import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

final searchPlaceProvider = Provider((ref) => SearchPlaceService());

class SearchPlaceService {
  /// Llama a la API de OSM Nominatim para buscar lugares
  /// 
  Future<List<Place>> searchPlaces(String query) async {
    final nominatim = Nominatim(
      userAgent: 'Dart osm_nominatim example',
    );
    if (query.isEmpty) return [];
    try {
      final List<Place> places = await nominatim.searchByName(
        query: query,
        limit: 5,
        addressDetails: true,
      );
      return places;
    } catch (e) {
      print('Error buscando lugares: $e');
      return [];
    }
  }
}
