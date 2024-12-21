import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? textColor;
  final bool isBold;
  final TextAlign? textAlign;
  final int? maxLines;
  final Icon? icon;

  const CustomText({
    super.key,
    required this.text,
    required this.fontSize,
    this.textColor,
    this.isBold = false,
    this.textAlign,
    this.maxLines,
    this.icon

  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: textAlign ?? TextAlign.start,
        maxLines: maxLines,
        text: TextSpan(
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: fontSize,
              color: textColor ?? Colors.white ,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              decorationColor: textColor,
            ),
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: icon,
                ),
              ),
              TextSpan(text: text)
            ]
        )
    );
  }
}
