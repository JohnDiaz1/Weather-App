import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/presentation/widgets/custom_bottom_navigation_bar.dart';

class MockGoRouter extends Mock implements GoRouter {}

class FakeContext extends Fake implements BuildContext {}

void main() {
  late MockGoRouter mockGoRouter;

  setUpAll(() {
    registerFallbackValue(FakeContext());
  });

  setUp(() {
    mockGoRouter = MockGoRouter();
  });

  Widget createWidgetUnderTest({required int currentIndex}) {
    return MaterialApp(
      home: InheritedGoRouter(
        goRouter: mockGoRouter,
        child: Scaffold(
          body: CustomBottomNavigation(
            currentIndex: currentIndex,
          ),
        ),
      ),
    );
  }

  group('CustomBottomNavigation Widget Tests', () {
    testWidgets('should render all navigation items', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(currentIndex: 0));

      // Verifica que se rendericen todos los items
      expect(find.byIcon(Icons.wb_cloudy_outlined), findsOneWidget);
      expect(find.byIcon(Icons.wb_sunny_outlined), findsOneWidget);
      expect(find.byIcon(Icons.map_outlined), findsOneWidget);
      expect(find.byIcon(Icons.favorite_outline), findsOneWidget);

      // Verifica las etiquetas
      expect(find.text('Diario'), findsOneWidget);
      expect(find.text('Pronóstico actual'), findsOneWidget);
      expect(find.text('Mapa'), findsOneWidget);
      expect(find.text('Favoritos'), findsOneWidget);
    });

    testWidgets('should highlight correct item based on currentIndex',
            (WidgetTester tester) async {
          await tester.pumpWidget(createWidgetUnderTest(currentIndex: 2));

          final BottomNavigationBar navigationBar =
          tester.widget(find.byType(BottomNavigationBar));
          expect(navigationBar.currentIndex, equals(2));
        });

    testWidgets('should navigate to correct route when tapping first item',
            (WidgetTester tester) async {
          when(() => mockGoRouter.go(any())).thenReturn(null);

          await tester.pumpWidget(createWidgetUnderTest(currentIndex: 1));

          await tester.tap(find.byIcon(Icons.wb_cloudy_outlined));
          await tester.pump();

          verify(() => mockGoRouter.go('/home/0')).called(1);
        });

    testWidgets('should navigate to correct route when tapping second item',
            (WidgetTester tester) async {
          when(() => mockGoRouter.go(any())).thenReturn(null);

          await tester.pumpWidget(createWidgetUnderTest(currentIndex: 0));

          await tester.tap(find.byIcon(Icons.wb_sunny_outlined));
          await tester.pump();

          verify(() => mockGoRouter.go('/home/1')).called(1);
        });

    testWidgets('should navigate to correct route when tapping third item',
            (WidgetTester tester) async {
          when(() => mockGoRouter.go(any())).thenReturn(null);

          await tester.pumpWidget(createWidgetUnderTest(currentIndex: 0));

          await tester.tap(find.byIcon(Icons.map_outlined));
          await tester.pump();

          verify(() => mockGoRouter.go('/home/2')).called(1);
        });

    testWidgets('should navigate to correct route when tapping fourth item',
            (WidgetTester tester) async {
          when(() => mockGoRouter.go(any())).thenReturn(null);

          await tester.pumpWidget(createWidgetUnderTest(currentIndex: 0));

          await tester.tap(find.byIcon(Icons.favorite_outline));
          await tester.pump();

          verify(() => mockGoRouter.go('/home/3')).called(1);
        });

    testWidgets('should have correct number of items', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(currentIndex: 0));

      final BottomNavigationBar navigationBar =
      tester.widget(find.byType(BottomNavigationBar));
      expect(navigationBar.items.length, equals(4));
    });

    testWidgets('should have zero elevation', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(currentIndex: 0));

      final BottomNavigationBar navigationBar =
      tester.widget(find.byType(BottomNavigationBar));
      expect(navigationBar.elevation, equals(0));
    });

    testWidgets('should maintain selection when rebuilding',
            (WidgetTester tester) async {
          await tester.pumpWidget(createWidgetUnderTest(currentIndex: 2));

          final BottomNavigationBar firstRender =
          tester.widget(find.byType(BottomNavigationBar));
          expect(firstRender.currentIndex, equals(2));

          await tester.pumpWidget(createWidgetUnderTest(currentIndex: 2));

          final BottomNavigationBar secondRender =
          tester.widget(find.byType(BottomNavigationBar));
          expect(secondRender.currentIndex, equals(2));
        });
  });
}