import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../service/json_service.dart';
import 'language/localization_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
    required this.changeLocale,
    required this.currentLocale,
  }) : super(key: key);

  final void Function(Locale) changeLocale;
  final Locale currentLocale;

  Future<bool> isLanguageSelectionDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_language_selected') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: FutureBuilder(
        future: Future.wait([
          JsonService.loadJsonData(context), // JSON verisinin yüklenmesi
          isLanguageSelectionDone()
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // JSON verisi yüklenirken bir yükleniyor göstergesi göster
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              // JSON verisi yüklenemezse bir hata mesajı göster
              return const Center(
                child: Text('JSON verisi yüklenirken hata oluştu'),
              );
            } else {
              bool isLanguageSelected = snapshot.data![1];

              Future.delayed(const Duration(seconds: 2), () {
                if (!isLanguageSelected) {
                  // Dil seçimi yapılmamışsa dil seçim sayfasına yönlendir
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocalizationPage(
                        changeLocale: changeLocale,
                        currentLocale: currentLocale,
                      ),
                    ),
                  );
                } else {
                  // Dil seçimi yapılmışsa ana sayfaya yönlendir
                  Navigator.pushReplacementNamed(context, '/navigationBar');
                }
              });

              return Center(
                child: Image.asset(
                  JsonService.getLogoUrl(context),
                  width: 30.h,
                  height: 30.h,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
