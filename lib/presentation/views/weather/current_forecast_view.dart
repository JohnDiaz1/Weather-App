import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/presentation/providers/providers.dart';
import 'package:weather_app/presentation/widgets/custom_daily_forecast.dart';
import 'package:weather_app/presentation/widgets/custom_text.dart';
import '../../../domain/models/current_forecast_model.dart';
import '../../widgets/custom_card_minutely_forecast.dart';

class CurrentForecastView extends ConsumerWidget {
  const CurrentForecastView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.watch(isConnectedProvider);
    final currentForecastAsync = ref.watch(currentForecastWithOfflineProvider);

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

              currentForecastAsync.when(
                data: (forecast) => _buildForecastInfo(forecast),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
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

  Widget _buildForecastInfo(CurrentForecast forecast) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const CustomText(
          text: "Pronóstico por hora",
          fontSize: 25,
          isBold: true,
        ),
        const SizedBox(height: 5),
        CustomCardMinutelyForecast(
          items: forecast.hourly,
        ),
        const SizedBox(height: 20),
        const CustomText(
          text: "Pronóstico para 8 días",
          fontSize: 25,
          isBold: true,
        ),
        const SizedBox(height: 5),
        CustomDailyForecast(
          dailyData: forecast.daily,
        ),
      ],
    );
  }
}