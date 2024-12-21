import 'package:flutter_dotenv/flutter_dotenv.dart';

String? home = dotenv.env['URL_API_WEATHER'] ?? 'URL_API_WEATHER not found';
String? apiKey = dotenv.env['API_KEY_WEATHER'] ?? 'API_KEY_WEATHER not found';

String get urlGetDailyAggregations => '$home/day_summary';
String get urlGetCurrentForecast => '$home';