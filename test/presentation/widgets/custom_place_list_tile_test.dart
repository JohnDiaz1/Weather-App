import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/presentation/widgets/custom_place_list_tile.dart';
import 'package:weather_app/presentation/widgets/custom_text.dart';

// CustomText Mock que extiende StatelessWidget
class MockCustomText extends StatelessWidget implements CustomText {
  @override
  final String text;
  @override
  final double fontSize;
  @override
  final bool isBold;
  @override
  final Color? textColor;

  const MockCustomText({
    required this.text,
    required this.fontSize,
    required this.isBold,
    this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) => const SizedBox();

  @override
  // TODO: implement icon
  Icon? get icon => throw UnimplementedError();

  @override
  // TODO: implement maxLines
  int? get maxLines => throw UnimplementedError();

  @override
  // TODO: implement textAlign
  TextAlign? get textAlign => throw UnimplementedError();
}

void main() {
  Widget createWidgetUnderTest({
    required String mainText,
    String? address,
    Icon? icon,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: PlaceListTile(
          mainText: mainText,
          address: address,
          icon: icon,
        ),
      ),
    );
  }

  group('PlaceListTile Widget Tests', () {
    testWidgets('should render all basic components', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        mainText: 'Test Place',
      ));

      expect(find.byType(ListTile), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byIcon(Icons.location_on), findsOneWidget);
    });

    testWidgets('should render main text with correct properties',
            (WidgetTester tester) async {
          const testMainText = 'Test Place';
          await tester.pumpWidget(createWidgetUnderTest(
            mainText: testMainText,
          ));

          final titleTextFinder = find.byWidgetPredicate((widget) {
            if (widget is! CustomText) return false;
            return widget.text == testMainText &&
                widget.fontSize == 15 &&
                widget.isBold == true &&
                widget.textColor == Colors.black;
          });

          expect(titleTextFinder, findsOneWidget);
        });

    testWidgets('should render address with correct properties when provided',
            (WidgetTester tester) async {
          const testAddress = 'Test Address 123';
          await tester.pumpWidget(createWidgetUnderTest(
            mainText: 'Test Place',
            address: testAddress,
          ));

          final addressTextFinder = find.byWidgetPredicate((widget) {
            if (widget is! CustomText) return false;
            return widget.text == testAddress &&
                widget.fontSize == 12 &&
                widget.isBold == false &&
                widget.textColor == Colors.grey;
          });

          expect(addressTextFinder, findsOneWidget);
        });

    testWidgets('should render empty string when address is null',
            (WidgetTester tester) async {
          await tester.pumpWidget(createWidgetUnderTest(
            mainText: 'Test Place',
            address: null,
          ));

          final addressTextFinder = find.byWidgetPredicate((widget) {
            if (widget is! CustomText) return false;
            return widget.text == '' &&
                widget.fontSize == 12 &&
                widget.isBold == false &&
                widget.textColor == Colors.grey;
          });

          expect(addressTextFinder, findsOneWidget);
        });

    testWidgets('should render custom icon when provided',
            (WidgetTester tester) async {
          const testIcon = Icon(Icons.star);
          await tester.pumpWidget(createWidgetUnderTest(
            mainText: 'Test Place',
            icon: testIcon,
          ));

          expect(find.byIcon(Icons.star), findsOneWidget);
        });

    testWidgets('should not render trailing icon when not provided',
            (WidgetTester tester) async {
          await tester.pumpWidget(createWidgetUnderTest(
            mainText: 'Test Place',
          ));

          final listTile = tester.widget<ListTile>(find.byType(ListTile));
          expect(listTile.trailing, isNull);
        });

    testWidgets('should be tappable', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        mainText: 'Test Place',
      ));

      final listTile = find.byType(ListTile);
      expect(tester.widget<ListTile>(listTile).onTap, isNotNull);
    });

    testWidgets('should maintain layout hierarchy', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        mainText: 'Test Place',
      ));

      expect(find.descendant(
        of: find.byType(Column),
        matching: find.byType(ListTile),
      ), findsOneWidget);
    });
  });
}