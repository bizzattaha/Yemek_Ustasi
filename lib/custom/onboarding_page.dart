import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'navigationBar_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage(
      {super.key, required this.currentLocale, required this.changeLocale});
  final Locale currentLocale;
  final Function(Locale) changeLocale;
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  //welcome title text widget
                  child: Text(
                    AppLocalizations.of(context)!.welcome_title,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  //welcome description widget
                  AppLocalizations.of(context)!.welcome_description,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    //2 onboarding route widget
                    context,
                    MaterialPageRoute(
                        builder: (context) => OnboardingPage2(
                              currentLocale: widget.currentLocale,
                            )));
              },
              child: Container(
                height: 10.h,
                width: 40.h,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    //next button widget
                    AppLocalizations.of(context)!.next_button,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 50,
            right: 50,
            child: Image.asset(
              'assets/splash/2.png',
              width: 30.h,
              height: 30.h,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage2 extends StatefulWidget {
  const OnboardingPage2({super.key, required this.currentLocale});
  final Locale currentLocale;

  @override
  State<OnboardingPage2> createState() => _OnboardingPage2State();
}

class _OnboardingPage2State extends State<OnboardingPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.discover_title,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.discover_description,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OnboardingPage3(
                              currentLocale: widget.currentLocale,
                            )));
              },
              child: Container(
                height: 10.h,
                width: 40.h,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.next_button,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 50,
            right: 50,
            child: Image.asset(
              'assets/splash/3.png',
              width: 30.h,
              height: 30.h,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage3 extends StatefulWidget {
  const OnboardingPage3({super.key, required this.currentLocale});
  final Locale currentLocale;

  @override
  State<OnboardingPage3> createState() => _OnboardingPage3State();
}

class _OnboardingPage3State extends State<OnboardingPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.get_started_title,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.get_started_description,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () async {
                await saveLocale(
                    'tr_TR'); // Örnek olarak Türkçe locale'ı kaydedelim
                Navigator.pushReplacement(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                      builder: (context) => NavigationBarPage(
                            currentLocale: widget.currentLocale,
                            changeLocale: (Locale) {},
                          )), // Ana sayfaya yönlendir
                );
              },
              child: Container(
                height: 10.h,
                width: 40.h,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.next_button,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 50,
            right: 50,
            child: Image.asset(
              'assets/splash/4.png',
              width: 30.h,
              height: 30.h,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> saveLocale(String locale) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('locale', locale);
}
