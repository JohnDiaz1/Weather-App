import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/models/current_forecast_model.dart';
import 'package:weather_app/presentation/widgets/custom_text.dart';

class CustomCardMinutelyForecast extends StatelessWidget {
  final List<Current> items;

  const CustomCardMinutelyForecast({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {

    String convertUnixToFormattedDate(int unixTimestamp) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
      return DateFormat.jm().format(dateTime);
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Container(
                width: 60, // Ancho fijo para cada elemento
                margin: const EdgeInsets.only(right: 8), // Espaciado horizontal entre elementos
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: convertUnixToFormattedDate(items[index].dt),
                      fontSize: 12,
                      isBold: true,
                    ),
                    const SizedBox(height: 4),
                    Image.network(
                      'http://openweathermap.org/img/w/${items[index].weather.first.icon}.png',
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon (
                          Icons.error,
                          color: Colors.red,
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                    CustomText(
                      text: '${items[index].temp.round()}°C',
                      fontSize: 12,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
