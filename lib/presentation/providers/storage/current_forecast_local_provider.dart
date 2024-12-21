import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/current_forecast_model.dart';
import '../../../infraestructure/repositories/current_forecast_repository.dart';
import '../providers.dart';
import '../../../infraestructure/mappers/current_forecast_mapper.dart';


final currentForecastRepositoryProvider = Provider<CurrentForecastRepository>((ref) {
  return CurrentForecastRepository();
});

/// Provider que gestiona los datos del pronóstico con soporte offline
final currentForecastWithOfflineProvider = FutureProvider<CurrentForecast>((ref) async {
  final repository = ref.watch(currentForecastRepositoryProvider);
  final connectivityStatus = ref.watch(isConnectedProvider);

  if (connectivityStatus) {
     try {
       final onlineData = await ref.watch(currentForecastProvider.future);
       final forecastEntity = CurrentForecastMapper.toEntity(onlineData);

       await repository.saveForecast(forecastEntity);

       return onlineData;
     }catch (e) {
       throw Exception('$e');
     }
  }

    final cachedForecast = repository.getLatestForecast();

    if (cachedForecast != null) {
      return CurrentForecastMapper.fromEntity(cachedForecast);
    }

    throw Exception('No hay datos disponibles. Se requiere conexión a internet para la primera carga.');
});
