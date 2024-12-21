import 'package:flutter/material.dart';
import 'package:weather_app/presentation/widgets/custom_text.dart';

class CustomCardDetails extends StatelessWidget {
  final String cardText;
  final String numberText;
  final IconData icon;
  final bool? hasShape;

  const CustomCardDetails({
    super.key,
    required this.cardText,
    required this.numberText,
    required this.icon,
    this.hasShape,

  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 110,
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 25,
              color: Colors.white,
            ),
            const SizedBox(height: 5,),
             CustomText(
                text: cardText,
                fontSize: 15,
            ),
            const SizedBox(height: 5,),
             CustomText(
              text: numberText,
              fontSize: 20,
               isBold: true,
            ),
          ],
        ),
      ),
    );
  }
}
