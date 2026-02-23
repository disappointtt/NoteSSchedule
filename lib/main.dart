import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:notes_schedule/app/state/app_settings.dart';
import 'package:notes_schedule/app/state/tasks_state.dart';
import 'package:notes_schedule/app/theme/app_theme.dart';
import 'package:notes_schedule/features/home/home_shell.dart';


// Точка входа (студенческий стиль)
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // тут настройки приложения (можно было и без async, но пусть будет)
  var settings = AppSettings();
  await settings.init();
  runApp(MyApp(appSettings: settings));
}


// Основное приложение (тут провайдеры и MaterialApp)
class MyApp extends StatelessWidget {
  final AppSettings appSettings;

  const MyApp({Key? key, required this.appSettings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appSettings),
        ChangeNotifierProvider(create: (_) => TasksState()),
      ],
      child: Consumer<AppSettings>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: 'NoteSSchedule',
            theme: AppTheme.lightTheme(settings.fontScale),
            darkTheme: AppTheme.darkTheme(settings.fontScale),
            themeMode: settings.themeMode,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            supportedLocales: const [Locale('ru', 'RU')],
            home: const HomeShell(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
