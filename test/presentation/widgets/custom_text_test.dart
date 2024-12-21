import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/presentation/widgets/custom_text.dart';

void main() {
  group('CustomText Widget Tests', () {
    testWidgets('renders text with default properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomText(
              text: 'Hello',
              fontSize: 16.0,
            ),
          ),
        ),
      );

      final richTextFinder = find.byType(RichText);
      expect(richTextFinder, findsOneWidget);

      final RichText richText = tester.widget<RichText>(richTextFinder);
      final TextSpan textSpan = richText.text as TextSpan;

      // Verifica el estilo del texto
      expect(textSpan.style?.fontSize, 16.0);
      expect(textSpan.style?.color, Colors.white);
      expect(textSpan.style?.fontFamily, 'Nunito');
      expect(textSpan.style?.fontWeight, FontWeight.normal);

      // Verifica que el texto está presente
      expect(textSpan.children?.last as TextSpan, isA<TextSpan>());
      expect((textSpan.children?.last as TextSpan).text, 'Hello');
    });

    testWidgets('renders text with custom properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomText(
              text: 'Bold Text',
              fontSize: 20.0,
              textColor: Colors.blue,
              isBold: true,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        ),
      );

      final richTextFinder = find.byType(RichText);
      expect(richTextFinder, findsOneWidget);

      final RichText richText = tester.widget<RichText>(richTextFinder);
      final TextSpan textSpan = richText.text as TextSpan;

      // Verifica propiedades personalizadas
      expect(textSpan.style?.fontSize, 20.0);
      expect(textSpan.style?.color, Colors.blue);
      expect(textSpan.style?.fontWeight, FontWeight.bold);
      expect(richText.textAlign, TextAlign.center);
      expect(richText.maxLines, 1);

      // Verifica el texto
      expect(textSpan.children?.last as TextSpan, isA<TextSpan>());
      expect((textSpan.children?.last as TextSpan).text, 'Bold Text');
    });

    testWidgets('handles null icon correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomText(
              text: 'No Icon',
              fontSize: 14.0,
            ),
          ),
        ),
      );

      final richTextFinder = find.byType(RichText);
      expect(richTextFinder, findsOneWidget);

      final RichText richText = tester.widget<RichText>(richTextFinder);
      final TextSpan textSpan = richText.text as TextSpan;

      // Verifica que hay un WidgetSpan con un icono nulo
      expect(textSpan.children?[0], isA<WidgetSpan>());
      final widgetSpan = textSpan.children?[0] as WidgetSpan;
      final paddingWidget = widgetSpan.child as Padding;
      expect(paddingWidget.child, null);

      // Verifica el texto
      expect(textSpan.children?.last as TextSpan, isA<TextSpan>());
      expect((textSpan.children?.last as TextSpan).text, 'No Icon');
    });
  });
}