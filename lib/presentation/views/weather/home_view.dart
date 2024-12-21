import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/presentation/widgets/custom_card_details.dart';
import 'package:weather_app/presentation/widgets/custom_text.dart';
import '../../../domain/models/daily_aggregation_model.dart';
import '../../providers/providers.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherDailyAsync = ref.watch(weatherWithOfflineProvider);
    final locationNameAsync = ref.watch(nameLocationProvider);
    final isOffline = ref.watch(isConnectedProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              isOffline
                  ? const SizedBox.shrink()
                  : const Chip(
                      label: Text('Modo sin conexión'),
                      avatar: Icon(Icons.offline_bolt),
                    ),

              !isOffline
                  ? const SizedBox.shrink()
                  : locationNameAsync.when(
                      data: (place) => CustomText(
                        icon: const Icon(Icons.navigation),
                        text: place.displayName.split(',')[0].trim(),
                        fontSize: 15,
                      ),
                      loading: () => const Center(),
                      error: (err, stack) => const SizedBox(
                        height: 0.1,
                      ),
                    ),
              weatherDailyAsync.when(
                data: (weather) => _buildWeatherInfo(weather),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cloud_off, size: 48),
                      const SizedBox(height: 16),
                      CustomText(
                        text: err.toString(),
                        fontSize: 20,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(DailyAggregation weather) {
    final currentDate =
        DateFormat('EEEE, MMMM d, h:mm a', 'es').format(DateTime.now());

    return Column(
      children: [
        CustomText(
          text: '${weather.temperature.max?.round()}°C',
          fontSize: 70,
          isBold: true,
        ),
        CustomText(
          text: currentDate,
          fontSize: 20,
        ),
        const SizedBox(
          height: 20,
        ),
        //TODO: Separar esta logica es decir crear un solo widget encargado de esto
        Card(
          child: SizedBox(
            height: 210,
            child: GridView.count(
              childAspectRatio: 2,
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CustomCardDetails(
                  icon: Icons.water_drop,
                  cardText: 'Humedad',
                  numberText: '${weather.humidity.afternoon}%',
                ),
                CustomCardDetails(
                  icon: Icons.compress,
                  cardText: 'Presión',
                  numberText: '${weather.pressure.afternoon} in',
                ),
                CustomCardDetails(
                  icon: Icons.air,
                  cardText: 'Viento',
                  numberText: '${weather.wind.max.speed} Km/H',
                ),
                CustomCardDetails(
                  icon: Icons.cloud,
                  cardText: 'Nubes',
                  numberText: '${weather.cloudCover.afternoon}%',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const CustomText(
              text: "Temperatura",
              fontSize: 30,
              icon: Icon(Icons.thermostat),
              isBold: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: SizedBox(
                height: 320,
                child: GridView.count(
                  childAspectRatio: 2,
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    CustomCardDetails(
                      icon: Icons.arrow_downward,
                      cardText: 'Minimo',
                      numberText: '${weather.temperature.min?.round()}°C',
                    ),
                    CustomCardDetails(
                      icon: Icons.arrow_upward,
                      cardText: 'Maxima',
                      numberText: '${weather.temperature.max?.round()}°C',
                    ),
                    CustomCardDetails(
                      icon: Icons.sunny,
                      cardText: 'En la tarde',
                      numberText: '${weather.temperature.afternoon?.round()}°C',
                    ),
                    CustomCardDetails(
                      icon: Icons.nightlight,
                      cardText: 'En la noche',
                      numberText: '${weather.temperature.night?.round()}°C',
                    ),
                    CustomCardDetails(
                      icon: Icons.nights_stay,
                      cardText: 'En la noche',
                      numberText: '${weather.temperature.evening?.round()}°C',
                    ),
                    CustomCardDetails(
                      icon: Icons.sunny,
                      cardText: 'En la manana',
                      numberText: '${weather.temperature.morning?.round()}°C',
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
