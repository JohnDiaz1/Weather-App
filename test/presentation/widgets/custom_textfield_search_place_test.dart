import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:realm_dart/src/realm_class.dart';
import 'package:weather_app/infraestructure/entities/place_entity.dart';
import 'package:weather_app/infraestructure/repositories/place_repository.dart';
import 'package:weather_app/presentation/providers/search/search_provider.dart';
import 'package:weather_app/presentation/providers/storage/favorite_locations_local_provider.dart';
import 'package:weather_app/presentation/widgets/custom_text.dart';
import 'package:weather_app/presentation/widgets/custom_textfield_seacrh_place.dart';

// Mock de SearchService
class MockSearchService extends SearchPlaceService {
  @override
  Future<List<Place>> searchPlaces(String query) async {
    if (query == 'error') throw Exception('Search error');

    return [
      Place(
        placeId: 1,
        osmType: 'node',
        osmId: 123,
        lat: 40.7128,
        lon: -74.0060,
        displayName: 'New York',
        placeRank: 1,
        category: 'place',
        type: 'city',
        importance: 0.9, boundingBox: [],
      ),
      Place(
        placeId: 2,
        osmType: 'node',
        osmId: 456,
        lat: 51.5074,
        lon: -0.1278,
        displayName: 'London',
        placeRank: 1,
        category: 'place',
        type: 'city',
        importance: 0.8, boundingBox: [],
      ),
    ];
  }
}

// Mock de PlaceRepository
class MockPlaceRepository implements PlaceRepository {
  bool shouldSucceed = true;

  @override
  Future<bool> savePlace(PlaceEntity place) async {
    return shouldSucceed;
  }

  @override
  Future<List<PlaceEntity>> getPlaces() async {
    return [];
  }

  @override
  Future<bool> deletePlace(int id) async {
    return true;
  }

  @override
  Future<bool> clearAllPlaces() {
    // TODO: implement clearAllPlaces
    throw UnimplementedError();
  }

  @override
  List<PlaceEntity> getAllPlaces() {
    // TODO: implement getAllPlaces
    throw UnimplementedError();
  }

  @override
  Stream<List<PlaceEntity>> getAllPlacesStream() {
    // TODO: implement getAllPlacesStream
    throw UnimplementedError();
  }

  @override
  // TODO: implement realm
  Realm get realm => throw UnimplementedError();
}

void main() {
  late ProviderContainer container;
  late MockSearchService mockSearchService;
  late MockPlaceRepository mockPlaceRepository;

  setUp(() {
    mockSearchService = MockSearchService();
    mockPlaceRepository = MockPlaceRepository();

    container = ProviderContainer(
      overrides: [
        searchPlaceProvider.overrideWithValue(mockSearchService),
        placeRepositoryProvider.overrideWithValue(mockPlaceRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  Widget createWidgetUnderTest(void Function(Place) onPlaceSelected) {
    return ProviderScope(
      parent: container,
      child: MaterialApp(
        home: Scaffold(
          body: SearchPlaceTextField(
            onPlaceSelected: onPlaceSelected,
          ),
        ),
      ),
    );
  }

  group('SearchPlaceTextField Widget Tests', () {
    testWidgets('should render initial state correctly',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            createWidgetUnderTest((place) {}),
          );

          expect(find.byType(TextField), findsOneWidget);
          expect(find.byIcon(Icons.search), findsOneWidget);
          expect(find.byIcon(Icons.clear), findsOneWidget);
          expect(find.byType(CircularProgressIndicator), findsNothing);
          expect(find.byType(ListView), findsNothing);
        });

    testWidgets('should show search results', (WidgetTester tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest((place) {}),
      );

      // Ingresa texto para buscar
      await tester.enterText(find.byType(TextField), 'France');
      await tester.pump();
      await tester.pumpAndSettle();

      // Verifica que se muestren los resultados
      expect(find.text('France'), findsOneWidget);
      //expect(find.text('London'), findsOneWidget);
      expect(find.byIcon(Icons.location_on), findsNWidgets(2));
    });

    testWidgets('should clear search results when clicking clear button',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            createWidgetUnderTest((place) {}),
          );

          // Realiza una búsqueda
          await tester.enterText(find.byType(TextField), 'New');
          await tester.pump();
          await tester.pumpAndSettle();

          // Presiona el botón de limpiar
          await tester.tap(find.byIcon(Icons.clear));
          await tester.pump();

          // Verifica que se hayan limpiado los resultados
          expect(find.byType(ListView), findsNothing);
          expect(find.text('New York'), findsNothing);
        });

    testWidgets('should show success snackbar when saving place succeeds',
            (WidgetTester tester) async {
          mockPlaceRepository.shouldSucceed = true;

          await tester.pumpWidget(
            createWidgetUnderTest((place) {}),
          );

          // Realiza una búsqueda
          await tester.enterText(find.byType(TextField), 'New');
          await tester.pump();
          await tester.pumpAndSettle();

          // Toca el botón de favorito
          await tester.tap(find.byIcon(Icons.favorite_border).first);
          await tester.pumpAndSettle();

          // Verifica que aparezca el Snackbar de éxito
          expect(find.byType(SnackBar), findsOneWidget);
          expect(find.text('Lugar guardado: New York'), findsOneWidget);
        });

    testWidgets('should show error snackbar when saving place fails',
            (WidgetTester tester) async {
          mockPlaceRepository.shouldSucceed = false;

          await tester.pumpWidget(
            createWidgetUnderTest((place) {}),
          );

          // Realiza una búsqueda
          await tester.enterText(find.byType(TextField), 'New');
          await tester.pump();
          await tester.pumpAndSettle();

          // Toca el botón de favorito
          await tester.tap(find.byIcon(Icons.favorite_border).first);
          await tester.pumpAndSettle();

          // Verifica que aparezca el Snackbar de error
          expect(find.byType(SnackBar), findsOneWidget);
          expect(find.text('Error al guardar el lugar'), findsOneWidget);
        });

    testWidgets('should not search with less than 3 characters',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            createWidgetUnderTest((place) {}),
          );

          // Ingresa solo 2 caracteres
          await tester.enterText(find.byType(TextField), 'Ne');
          await tester.pump();
          await tester.pumpAndSettle();

          // Verifica que no se muestren resultados
          expect(find.byType(ListView), findsNothing);
          expect(find.byType(CircularProgressIndicator), findsNothing);
        });
  });
}