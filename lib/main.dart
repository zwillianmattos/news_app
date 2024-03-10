import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/app_widget.dart';

import 'app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.close();
  await Hive.openBox<String>('source_data_cache');
  Modular.setInitialRoute('/sources/');
  runApp(
    ModularApp(
      module: AppModule(),
      debugMode: true,
      child: const App(),
    ),
  );
}
