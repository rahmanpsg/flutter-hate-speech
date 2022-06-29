import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hate_speech_classification/app/app.router.dart';
import 'package:hate_speech_classification/services/data_service.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.locator.dart';
import 'themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  await locator<DataService>().syncData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hate Speech Classification',
        theme: appTheme,
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        initialRoute: Routes.bottomNavView);
  }
}
