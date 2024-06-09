import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yemek_ustasi/view/home/home_page.dart';
import 'package:yemek_ustasi/custom/onboarding_page.dart';
import 'package:yemek_ustasi/view/splash_page.dart';
import 'l10n/l10.dart';
import 'provider/theme_provider.dart';
import 'custom/navigationBar_page.dart';
import 'view/language/localization_page.dart';
import 'view/product/product_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Locale initialLocale = await getSavedLocale(); //read language
  bool isLanguageSelected =
      await isLanguageSelectionDone(); //read if language is selected
  runApp(MyApp(
    initialLocale: initialLocale,
    isLanguageSelected: isLanguageSelected,
  ));
}

//Language read function
Future<Locale> getSavedLocale() async {
  final prefs = await SharedPreferences.getInstance();
  final languageCode = prefs.getString('language_code') ?? '';
  return Locale(languageCode.isEmpty ? 'en' : languageCode); // default language
}

// Check if language selection is done
Future<bool> isLanguageSelectionDone() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('is_language_selected') ?? false;
}

class MyApp extends StatefulWidget {
  const MyApp(
      {super.key,
      required this.initialLocale,
      required this.isLanguageSelected});
  final Locale initialLocale;
  final bool isLanguageSelected;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _currentLocale;

  @override
  void initState() {
    super.initState();
    _currentLocale = widget.initialLocale;
    _currentLocale = widget.initialLocale;
  }

  // Dil değiştirme işlevi
  void _changeLocale(Locale newLocale) async {
    setState(() {
      _currentLocale = newLocale;
    });

    // Yeni seçilen dili kaydet
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', newLocale.languageCode);
    await prefs.setBool('is_language_selected', true);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: '/',
                routes: {
                  '/product': (context) => ProductPage(
                        currentLocale: _currentLocale,
                      ),
                  '/language': (context) => LocalizationPage(
                        changeLocale: _changeLocale,
                        currentLocale: _currentLocale,
                      ),
                  '/': (context) => SplashScreen(
                        changeLocale: _changeLocale,
                        currentLocale: _currentLocale,
                      ),
                  '/onBoarding': (context) => OnboardingPage(
                        changeLocale: _changeLocale,
                        currentLocale: _currentLocale,
                      ),
                  '/home_page': (context) => const HomePage(),
                  '/navigationBar': (context) => NavigationBarPage(
                        currentLocale: _currentLocale,
                        changeLocale: _changeLocale,
                      ),
                },
                title: 'Yemek Ustası',
                theme: themeProvider.getThemeData(),
                supportedLocales: L10n.all,
                locale: _currentLocale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale!.languageCode &&
                        supportedLocale.countryCode == locale.countryCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.first;
                },
              );
            },
          );
        },
      ),
    );
  }
}
