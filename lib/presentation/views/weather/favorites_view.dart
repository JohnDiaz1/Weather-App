import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/storage/favorite_locations_local_provider.dart';
import '../../widgets/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/storage/favorite_locations_local_provider.dart';
import '../../widgets/custom_text.dart';

class FavoritesView extends ConsumerWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placeListAsync = ref.watch(placeListProvider);
    final placeRepository = ref.read(placeRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Favoritos',
          fontSize: 25,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever,color: Colors.white, size: 30,),
            onPressed: () async {
              final success = await placeRepository.clearAllPlaces();
              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      success
                          ? 'Todos los favoritos han sido eliminados'
                          : 'Error al eliminar favoritos'
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: placeListAsync.when(
        data: (places) {
          if (places.isEmpty) {
            return const Center(
              child: Text('No hay favoritos almacenados.'),
            );
          }

          return ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];

              // Store the values we need before any potential deletion
              final placeId = place.placeId;
              final displayName = place.displayName;
              final lat = place.lat;
              final lon = place.lon;

              return Dismissible(
                key: Key(placeId.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white, size: 30),
                ),
                onDismissed: (direction) async {
                  // Delete the place and handle the result
                  final success = await placeRepository.deletePlace(placeId);

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          success
                              ? 'Lugar eliminado: $displayName'
                              : 'Error al eliminar el lugar'
                      ),
                    ),
                  );
                },
                child: ListTile(
                  leading: const Icon(Icons.place, color: Colors.blue),
                  title: CustomText(
                    text: displayName,
                    fontSize: 20,
                  ),
                  subtitle: CustomText(
                    text: 'Lat: $lat, Lon: $lon',
                    fontSize: 15,
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
