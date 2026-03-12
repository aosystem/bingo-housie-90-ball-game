import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:bingogamehousie/l10n/app_localizations.dart';
import 'package:bingogamehousie/model.dart';
import 'package:bingogamehousie/home_page.dart';
import 'package:bingogamehousie/theme_mode_number.dart';
import 'package:bingogamehousie/loading_screen.dart';
import 'package:bingogamehousie/parse_locale_tag.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
    systemStatusBarContrastEnforced: false,
    systemNavigationBarContrastEnforced: false,
  ));
  MobileAds.instance.initialize();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  ThemeMode themeMode = ThemeMode.light;
  Locale? locale;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _initState();
  }

  void _initState() async {
    await Model.ensureReady();
    themeMode = ThemeModeNumber.numberToThemeMode(Model.themeNumber);
    locale = parseLocaleTag(Model.languageCode);
    setState(() {
      _isReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: LoadingScreen(),
          ),
        ),
      );
    }
    Color seed = Model.colorScheme == 1 ? Colors.blue : Colors.green;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
      themeMode: themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const MainHomePage(),
    );
  }
}
