import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  ThemeProvider() {
    _loadFromPrefs();
  }

  ThemeData getThemeData() {
    return _isDarkTheme
        ? ThemeData.dark().copyWith(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: Colors.black,
            canvasColor: const Color.fromARGB(250, 197, 209, 224),
            cardColor: Colors.white,
            primaryColor: const Color.fromRGBO(245, 109, 21, 0.992),
            navigationBarTheme: const NavigationBarThemeData(
              backgroundColor: Colors.white,
            ),
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
                    fontSize: 20, color: Color.fromRGBO(0, 34, 77, 2)),
                color: Colors.white),
            secondaryHeaderColor: Colors.white,
            textTheme: const TextTheme(
                displaySmall: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(245, 109, 21, 0.992),
                ),
                displayMedium: TextStyle(fontSize: 17, color: Colors.white),
                bodySmall: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(245, 109, 21, 0.992),
                ),
                bodyMedium: TextStyle(
                  fontSize: 16,
                  color: Colors.white
                ),
                bodyLarge: TextStyle(
                  fontSize: 24,
                  color: Color.fromRGBO(245, 109, 21, 0.992),
                ),
                titleSmall: TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(245, 109, 21, 0.992),
                ),
                titleMedium: TextStyle(
                    fontSize: 22,
                    color: Color.fromRGBO(245, 109, 21, 0.992),
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold),
                titleLarge: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                headlineLarge: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 34, 77, 2),
                    letterSpacing: 2),
                headlineMedium: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 34, 77, 2),
                    letterSpacing: 1),
                headlineSmall: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 34, 77, 2),
                )))
        : ThemeData.light().copyWith(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: Colors.white,
            canvasColor: const Color.fromARGB(250, 197, 209, 224),
            cardColor: Colors.white,
            primaryColor: const Color.fromRGBO(245, 109, 21, 0.992),
            navigationBarTheme: const NavigationBarThemeData(
              backgroundColor: Colors.white,
            ),
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
                    fontSize: 20, color: Color.fromRGBO(0, 34, 77, 2)),
                color: Colors.white),
            secondaryHeaderColor: Colors.white,
            textTheme: const TextTheme(
                displaySmall: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(245, 109, 21, 0.992),
                ),
                displayMedium: TextStyle(fontSize: 17, color: Colors.white),
                bodySmall: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(245, 109, 21, 0.992),
                ),
                bodyMedium: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                bodyLarge: TextStyle(
                  fontSize: 24,
                  color: Color.fromRGBO(245, 109, 21, 0.992),
                ),
                titleSmall: TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(245, 109, 21, 0.992),
                ),
                titleMedium: TextStyle(
                    fontSize: 22,
                    color: Color.fromRGBO(245, 109, 21, 0.992),
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold),
                titleLarge: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                headlineLarge: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 34, 77, 2),
                    letterSpacing: 2),
                headlineMedium: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 34, 77, 2),
                    letterSpacing: 1),
                headlineSmall: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 34, 77, 2),
                )));
  }

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  void _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    notifyListeners();
  }

  void _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', _isDarkTheme);
  }
}
