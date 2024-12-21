import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';
import 'config/db/realm_config.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  RealmConfig.initializeRealm();
  await initializeDateFormatting('es', null);
  runApp(const ProviderScope(child: App(flavor: 'Development')));
}