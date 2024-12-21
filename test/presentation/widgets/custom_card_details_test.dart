import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/presentation/widgets/custom_card_details.dart';
import 'package:weather_app/presentation/widgets/custom_text.dart';

void main() {
  group('CustomCardDetails Widget Tests', () {
    testWidgets('renders all components correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCardDetails(
              cardText: 'Wind',
              numberText: '10 km/h',
              icon: Icons.air,
            ),
          ),
        ),
      );

      // Verifica la estructura básica
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);

      // Encuentra todos los SizedBox
      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));

      // Encuentra el SizedBox principal (110x110)
      final mainSizedBox = sizedBoxes.firstWhere(
              (box) => box.width == 110 && box.height == 110
      );
      expect(mainSizedBox.width, 110);
      expect(mainSizedBox.height, 110);

      // Verifica los espaciadores de 5 pixels
      final spacers = sizedBoxes.where((box) => box.height == 5);
      expect(spacers.length, 2);

      // Verifica el icono
      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.icon, Icons.air);
      expect(icon.size, 25);
      expect(icon.color, Colors.white);

      // Verifica los CustomText widgets
      final customTexts = tester.widgetList<CustomText>(find.byType(CustomText));
      expect(customTexts.length, 2);

      // Verifica el primer CustomText (cardText)
      final cardTextWidget = customTexts.elementAt(0);
      expect(cardTextWidget.text, 'Wind');
      expect(cardTextWidget.fontSize, 15);
      expect(cardTextWidget.isBold, false);

      // Verifica el segundo CustomText (numberText)
      final numberTextWidget = customTexts.elementAt(1);
      expect(numberTextWidget.text, '10 km/h');
      expect(numberTextWidget.fontSize, 20);
      expect(numberTextWidget.isBold, true);
    });

    testWidgets('renders with different icon and text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCardDetails(
              cardText: 'Humidity',
              numberText: '75%',
              icon: Icons.water_drop,
            ),
          ),
        ),
      );

      // Verifica el icono
      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.icon, Icons.water_drop);

      // Verifica los textos
      final customTexts = tester.widgetList<CustomText>(find.byType(CustomText));
      expect(customTexts.elementAt(0).text, 'Humidity');
      expect(customTexts.elementAt(1).text, '75%');
    });

    testWidgets('applies correct alignment and spacing', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCardDetails(
              cardText: 'Test',
              numberText: '123',
              icon: Icons.router,
            ),
          ),
        ),
      );

      // Verifica la alineación de la columna
      final column = tester.widget<Column>(find.byType(Column));
      expect(column.mainAxisAlignment, MainAxisAlignment.center);

      // Verifica los espaciadores
      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      final spacers = sizedBoxes.where((box) => box.height == 5);
      expect(spacers.length, 2);
    });

    testWidgets('layout order is correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCardDetails(
              cardText: 'Test',
              numberText: '123',
              icon: Icons.router,
            ),
          ),
        ),
      );

      // Obtiene las posiciones de los widgets
      final iconPosition = tester.getCenter(find.byType(Icon));
      final texts = find.byType(CustomText);
      final firstTextPosition = tester.getCenter(texts.first);
      final secondTextPosition = tester.getCenter(texts.last);

      // Verifica que los elementos están en el orden correcto verticalmente
      expect(iconPosition.dy, lessThan(firstTextPosition.dy));
      expect(firstTextPosition.dy, lessThan(secondTextPosition.dy));
    });
  });
}