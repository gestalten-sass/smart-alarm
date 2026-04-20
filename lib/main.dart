import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/app_localizations.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/info_screen.dart';

final ValueNotifier<Locale?> appLocale = ValueNotifier(null);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
  ));
  final prefs = await SharedPreferences.getInstance();
  final savedLocale = prefs.getString('locale');
  if (savedLocale != null) {
    appLocale.value = Locale(savedLocale);
  }
  runApp(const SmartAlarmApp());
}

class SmartAlarmApp extends StatelessWidget {
  const SmartAlarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale?>(
      valueListenable: appLocale,
      builder: (context, locale, _) {
        return MaterialApp(
          title: 'SmartAlarm',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('de'),
            Locale('en'),
            Locale('fr'),
            Locale('it'),
            Locale('es'),
            Locale('nl'),
          ],
          initialRoute: '/',
          routes: {
            '/': (_) => const HomeScreen(),
            '/settings': (_) => const SettingsScreen(),
            '/info': (_) => const InfoScreen(),
          },
        );
      },
    );
  }
}
