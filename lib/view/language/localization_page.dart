import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/json_service.dart';

// ignore: must_be_immutable
class LocalizationPage extends StatefulWidget {
  LocalizationPage({
    super.key,
    required this.changeLocale,
    required this.currentLocale,
  });

  Locale currentLocale;
  final Function(Locale) changeLocale;

  @override
  State<LocalizationPage> createState() => _LocalizationPageState();
}

class _LocalizationPageState extends State<LocalizationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

// _LocalizationPageState sınıfının _onLanguageSelected fonksiyonu
  Future<void> _onLanguageSelected(Locale locale) async {
    widget.changeLocale(locale);
    setState(() {
      widget.currentLocale = locale;
    });

    // Save the language selection
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_language_selected', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Image.asset(
            JsonService.getLogoUrl(context),
            width: 30.h,
            height: 30.h,
          ),
          SizedBox(
            height: 8.h,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _offsetAnimation,
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.hello,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              AppLocalizations.of(context)!.choose_language,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            LanguageContainerWidget(
                              widget: widget,
                              language: 'Türkçe',
                              cCode: 'tr',
                              onLanguageSelected: _onLanguageSelected,
                            ),
                            LanguageContainerWidget(
                              widget: widget,
                              language: 'English',
                              cCode: 'en',
                              onLanguageSelected: _onLanguageSelected,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('is_language_selected', true);
                          Navigator.pushReplacementNamed(
                              context, '/onBoarding');
                        },
                        child: Container(
                          height: 10.h,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                            vertical: 20.sp,
                            horizontal: 6.sp,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.next_button,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LanguageContainerWidget extends StatelessWidget {
  LanguageContainerWidget({
    Key? key,
    required this.widget,
    required this.language,
    required this.cCode,
    required this.onLanguageSelected,
  });

  final LocalizationPage widget;
  final String cCode;
  final String language;
  final Function(Locale) onLanguageSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onLanguageSelected(
            Locale(cCode)); // Burada Locale bilgisini iletmek gerekiyor
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: widget.currentLocale.languageCode == cCode
                ? Theme.of(context).primaryColor
                : Colors.black,
          ),
          color: widget.currentLocale.languageCode == cCode
              ? Colors.black
              : Theme.of(context).primaryColor,
        ),
        child: Text(
          language,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
