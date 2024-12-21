import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infraestructure/entities/place_entity.dart';
import '../../../infraestructure/repositories/place_repository.dart';

/// Provider for the PlaceRepository
final placeRepositoryProvider = Provider<PlaceRepository>((ref) {
  return PlaceRepository();
});

/// StreamProvider that provides real-time updates of Places from Realm
final placeListProvider = StreamProvider<List<PlaceEntity>>((ref) {
  final repository = ref.watch(placeRepositoryProvider);
  return repository.getAllPlacesStream();
});