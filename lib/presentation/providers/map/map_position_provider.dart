import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class MapPosition {
  final LatLng position;
  final List<Marker> markers;

  MapPosition({required this.position, required this.markers});
}

class MapPositionNotifier extends StateNotifier<MapPosition> {
  MapPositionNotifier() : super(MapPosition(position: const LatLng(0, 0), markers: []));

  void updatePosition(LatLng newPosition) {
    state = MapPosition(
      position: newPosition,
      markers: [
        Marker(
          point: newPosition,
          width: 80,
          height: 80,
          child: const Icon(
            Icons.location_pin,
            size: 40,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

final mapPositionProvider = StateNotifierProvider<MapPositionNotifier, MapPosition>((ref) {
  return MapPositionNotifier();
});
