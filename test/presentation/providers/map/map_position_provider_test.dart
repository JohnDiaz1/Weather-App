import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:weather_app/presentation/providers/map/map_position_provider.dart';


void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('MapPositionNotifier Tests', () {
    test('should have initial state with position (0,0) and empty markers', () {
      final mapPosition = container.read(mapPositionProvider);

      expect(mapPosition.position, equals(const LatLng(0, 0)));
      expect(mapPosition.markers, isEmpty);
    });

    test('should update position and create marker when updatePosition is called', () {
      final notifier = container.read(mapPositionProvider.notifier);
      final newPosition = LatLng(51.5074, -0.1278); // London coordinates

      notifier.updatePosition(newPosition);

      final updatedState = container.read(mapPositionProvider);
      expect(updatedState.position, equals(newPosition));
      expect(updatedState.markers.length, equals(1));

      final marker = updatedState.markers.first;
      expect(marker.point, equals(newPosition));
      expect(marker.width, equals(80));
      expect(marker.height, equals(80));

      // Check if the marker's child is an Icon with correct properties
      final iconWidget = marker.child as Icon;
      expect(iconWidget.icon, equals(Icons.location_pin));
      expect(iconWidget.size, equals(40));
      expect(iconWidget.color, equals(Colors.red));
    });

    test('should replace existing marker when updating position multiple times', () {
      final notifier = container.read(mapPositionProvider.notifier);

      // First update
      final firstPosition = LatLng(51.5074, -0.1278);
      notifier.updatePosition(firstPosition);
      expect(container.read(mapPositionProvider).markers.length, equals(1));

      // Second update
      final secondPosition = LatLng(48.8566, 2.3522);
      notifier.updatePosition(secondPosition);

      final finalState = container.read(mapPositionProvider);
      expect(finalState.markers.length, equals(1));
      expect(finalState.markers.first.point, equals(secondPosition));
    });
  });
}