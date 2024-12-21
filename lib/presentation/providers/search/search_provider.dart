import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

final searchPlaceProvider = Provider((ref) => SearchPlaceService());

class SearchPlaceService {
  /// Llama a la API de OSM Nominatim para buscar lugares
  Future<List<Place>> searchPlaces(String query) async {
    if (query.isEmpty) return [];
    try {
      final List<Place> places = await Nominatim.searchByName(
        query: query,
        limit: 5, // Limita la cantidad de resultados
        addressDetails: true,
      );
      return places;
    } catch (e) {
      print('Error buscando lugares: $e');
      return [];
    }
  }
}
