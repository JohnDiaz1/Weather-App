import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:weather_app/presentation/providers/providers.dart';
import '../../../infraestructure/entities/daily_aggregation_entity.dart';
import '../../../infraestructure/mappers/daily_aggregation_mapper.dart';
import '../../../infraestructure/repositories/daily_aggregation_repository.dart';
import '../../../domain/models/daily_aggregation_model.dart';
import '../weather/weather_providers.dart';


final dailyAggregationRepositoryProvider = Provider<DailyAggregationRepository>((ref) {
  return DailyAggregationRepository();
});


/// Provider que maneja los datos del clima con soporte offline
final weatherWithOfflineProvider = FutureProvider<DailyAggregation>((ref) async {
  final repository = ref.watch(dailyAggregationRepositoryProvider);
  final connectivityStatus = ref.watch(isConnectedProvider);

  if (connectivityStatus) {
    try {
      final onlineData = await ref.watch(weatherProvider.future);
      final dailyAggregationEntity = DailyAggregationMapper.toEntity(onlineData);

      await repository.saveDailyAggregation(dailyAggregationEntity);
      return onlineData;
    } catch (e) {
      throw Exception('$e');
    }
  }

  final cachedData = repository.getLatestDailyAggregation();
  if (cachedData != null) {
    return DailyAggregationMapper.fromEntity(cachedData);
  }

  throw Exception('No hay datos disponibles. Compruebe su conexión a internet.');
});