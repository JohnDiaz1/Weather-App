import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/presentation/widgets/custom_text.dart';

import '../../domain/models/current_forecast_model.dart';

class CustomDailyForecast extends StatelessWidget {
  final List<Daily> dailyData;

  const CustomDailyForecast({super.key, required this.dailyData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dailyData.length,
      itemBuilder: (context, index) {
        final daily = dailyData[index];

        return CustomDailyCard(daily: daily);
      },
    );
  }
}

class CustomDailyCard extends StatelessWidget {
  final Daily daily;

  const CustomDailyCard({
    super.key,
    required this.daily,
  });

  @override
  Widget build(BuildContext context) {

    String convertUnixToFormattedDate(int unixTimestamp) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
      return DateFormat('EEEE, d MMMM', 'es').format(dateTime);
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: convertUnixToFormattedDate(daily.dt),
              fontSize: 18,
              isBold: true,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.network(
                      'http://openweathermap.org/img/w/${daily.weather.first.icon}.png',
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
                    const SizedBox(width: 8),
                    CustomText(
                      text:  daily.weather.first.description.toUpperCase(),
                      fontSize: 16,
                    ),
                  ],
                ),
                Text(
                  '${daily.temp.min.round()}°C / ${daily.temp.max.round()}°C',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Icon(Icons.water_drop, color: Colors.blue, size: 20),
                    const CustomText(
                        text: 'Humedad',
                        fontSize: 15
                    ),
                    CustomText(
                        text: '${daily.humidity}%',
                        fontSize: 15
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.air, color: Colors.green, size: 20),
                    const CustomText(
                        text: 'Viento',
                        fontSize: 15
                    ),
                    CustomText(
                        text: '${daily.windSpeed.toStringAsFixed(1)} km/h',
                        fontSize: 15
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.umbrella, color: Colors.blue, size: 20),
                    const CustomText(
                        text: 'Lluvia',
                        fontSize: 15
                    ),
                    CustomText(
                        text: '${daily.rain?.toStringAsFixed(1)} mm',
                        fontSize: 15
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}