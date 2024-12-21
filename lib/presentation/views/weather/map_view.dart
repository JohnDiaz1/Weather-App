import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:weather_app/presentation/widgets/custom_text.dart';
import 'package:weather_app/presentation/widgets/custom_textfield_seacrh_place.dart';
import '../../providers/providers.dart';

class MapView extends ConsumerStatefulWidget {
  const MapView({super.key});

  @override
  ConsumerState<MapView> createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<MapView> {
  // Controlador del mapa para manejar el movimiento
  final MapController _mapController = MapController();

  // Estado para mantener la posición del marcador actual
  LatLng? _selectedLocation;

  void _onPlaceSelected(Place place) {
    // Convertimos las coordenadas del lugar seleccionado a LatLng
    final newLocation = LatLng(
      place.lat,
      place.lon,
    );

    setState(() {
      _selectedLocation = newLocation;
    });

    // Movemos el mapa a la nueva ubicación con una animación
    _mapController.move(newLocation, 15.0);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Lugar seleccionado: ${place.displayName}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locationAsyncValue = ref.watch(userLocationProvider);

    return Scaffold(
      body: locationAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error: ${error.toString()}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => ref.refresh(userLocationProvider),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
        data: (position) {
          // Si no hay ubicación seleccionada, usamos la ubicación actual
          final currentLocation = _selectedLocation ??
              LatLng(position.latitude, position.longitude);

          return Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: currentLocation,
                  initialZoom: 15.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: currentLocation,
                        width: 80,
                        height: 80,
                        child: const Icon(
                          Icons.location_pin,
                          size: 40,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 8, right: 8),
                child: SearchPlaceTextField(
                  onPlaceSelected: _onPlaceSelected,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}