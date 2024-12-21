import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/presentation/providers/services/location_provider.dart';

class MockLocationProvider extends Mock implements LocationProvider {}
class MockPosition extends Mock implements Position {}

void main() {
  late MockLocationProvider mockLocationProvider;
  late ProviderContainer container;
  late Position mockPosition;

  setUp(() {
    mockLocationProvider = MockLocationProvider();
    mockPosition = MockPosition();

    container = ProviderContainer(
      overrides: [
        locationProvider.overrideWith((ref) => mockLocationProvider),
        userLocationProvider.overrideWith((ref) async {
          return await mockLocationProvider.getUserCurrentLocation();
        }),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('LocationProvider Tests', () {
    test('should return current position when location is available', () async {
      // Arrange
      when(() => mockPosition.latitude).thenReturn(40.7128);
      when(() => mockPosition.longitude).thenReturn(-74.0060);
      when(() => mockLocationProvider.getUserCurrentLocation())
          .thenAnswer((_) async => mockPosition);

      // Act
      final result = await container.read(userLocationProvider.future);

      // Assert
      expect(result, isNotNull);
      expect(result.latitude, 40.7128);
      expect(result.longitude, -74.0060);

      verify(() => mockLocationProvider.getUserCurrentLocation()).called(1);
    });

    test('should handle when location service is disabled', () async {
      // Arrange
      when(() => mockLocationProvider.getUserCurrentLocation())
          .thenThrow(const LocationServiceDisabledException());

      // Act & Assert
      expect(
            () => container.read(userLocationProvider.future),
        throwsA(isA<LocationServiceDisabledException>()),
      );
    });

    test('should handle when permission is denied', () async {
      // Arrange
      when(() => mockLocationProvider.getUserCurrentLocation())
          .thenThrow(const PermissionDeniedException('Location permission denied'));

      // Act & Assert
      expect(
            () => container.read(userLocationProvider.future),
        throwsA(isA<PermissionDeniedException>()),
      );
    });
  });
}