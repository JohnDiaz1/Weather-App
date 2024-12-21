import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:weather_app/infraestructure/entities/place_entity.dart';
import '../providers/search/search_provider.dart';
import '../providers/storage/favorite_locations_local_provider.dart';
import 'custom_text.dart';

class SearchPlaceTextField extends ConsumerStatefulWidget {
  final Function(Place) onPlaceSelected; // Callback al seleccionar un lugar

  const SearchPlaceTextField({
    super.key,
    required this.onPlaceSelected,
  });

  @override
  ConsumerState<SearchPlaceTextField> createState() =>
      _SearchPlaceTextFieldState();
}

class _SearchPlaceTextFieldState extends ConsumerState<SearchPlaceTextField> {
  final TextEditingController _controller = TextEditingController();
  List<Place> _places = [];
  bool _isLoading = false;

  /// Obtiene los lugares de la API de Nominatim y actualiza la lista
  Future<void> _getPlaces(String query) async {
    if (query.isEmpty) return;
    setState(() {
      _isLoading = true;
    });

    final searchService = ref.read(searchPlaceProvider);
    final results = await searchService.searchPlaces(query);

    setState(() {
      _places = results;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final placeRepository = ref
        .read(placeRepositoryProvider); // 🚀 Usar el provider del repositorio

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Campo de texto para buscar
        TextField(
          controller: _controller,
          onChanged: (value) {
            if (value.length > 2)
              _getPlaces(value); // Solo busca si hay más de 2 caracteres
          },
          decoration: InputDecoration(
            hintText: 'Buscar lugar...',
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                setState(() {
                  _places = [];
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        // Indicador de carga
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Center(child: CircularProgressIndicator()),
          ),

        // Lista de resultados (solo se muestra si hay elementos)
        if (_places.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Fondo blanco
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              // Elimina el padding del ListView
              itemCount: _places.length,
              itemBuilder: (context, index) {
                final place = _places[index];
                return Column(
                  children: [
                    if (index != 0)
                      const Divider(height: 1, color: Colors.grey),
                    // Divisor solo para los elementos después del primero
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      // Elimina el padding del ListTile
                      leading: const Icon(Icons.location_on),
                      tileColor: Colors.white,
                      title: CustomText(
                        text: place.displayName,
                        fontSize: 15,
                        textColor: Colors.black,
                      ),
                      // In the ListTile trailing IconButton of SearchPlaceTextField
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite_border, color: Colors.red),
                        onPressed: () async {
                          final placeRepository = ref.read(placeRepositoryProvider);

                          // Create the PlaceEntity
                          final placeEntity = PlaceEntity(
                            place.placeId,
                            place.osmType!,
                            place.osmId!,
                            place.lat,
                            place.lon,
                            place.displayName,
                            place.placeRank,
                            place.category,
                            place.type,
                            place.importance,
                          );

                          // Save the place and handle the result
                          final success = await placeRepository.savePlace(placeEntity);

                          if (success) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Lugar guardado: ${place.displayName}')),
                            );
                          } else {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Error al guardar el lugar')),
                            );
                          }
                        },
                      ),
                      onTap: () {
                        widget.onPlaceSelected(place);
                        _controller.text = place.displayName;
                        setState(() {
                          _places = [];
                        });
                      },
                    ),
                  ],
                );
              },
            ),
          ),
      ],
    );
  }
}
