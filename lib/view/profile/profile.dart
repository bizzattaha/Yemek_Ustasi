import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:yemek_ustasi/view/profile/controller/image_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../provider/theme_provider.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  ProfilePage({
    super.key,
    required this.changeLocale,
    required this.currentLocale,
  });

  Locale currentLocale;
  final Function(Locale) changeLocale;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImageController _controller = Get.put(ImageController());
  bool _isEnglishSelected = true; // Varsayılan olarak İngilizce seçili

  @override
  void initState() {
    super.initState();
    _controller.getData(); // Kaydedilen resmi getir
    _loadLanguage(); // Dil seçeneğini yüklemek için initState içinde çağırıyoruz.
  }

  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentLanguage = prefs.getString('language') ?? 'en';
    setState(() {
      _isEnglishSelected = currentLanguage == 'en';
    });
  }

  Future<void> _onLanguageSelected(bool isEnglishSelected) async {
    if (isEnglishSelected) {
      widget.changeLocale(Locale('en'));
    } else {
      widget.changeLocale(Locale('tr'));
    }

    // Dil seçimini kaydetme işlemi
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', isEnglishSelected ? 'en' : 'tr');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          AppLocalizations.of(context)!.recipes,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Center(
            child: Obx(
              () => ClipOval(
                child: Image.file(
                  File(_controller.imgPath!.value),
                  cacheWidth: 90,
                  cacheHeight: 90,
                  errorBuilder: (context, error, stackTrace) {
                    return const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        'https://as1.ftcdn.net/v2/jpg/03/53/11/00/1000_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg',
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context)
                  .scaffoldBackgroundColor, // foreground (text) color
              backgroundColor:
                  Theme.of(context).primaryColor, // background color
            ),
            onPressed: () {
              setState(() {
                _controller.pickImage(); // Resmi seç ve kaydet
              });
            },
            child: Text(
              AppLocalizations.of(context)!.choose_image,
            ),
          ),
          CardWidget(
            text: AppLocalizations.of(context)!.theme,
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            widget: Icon(
              Provider.of<ThemeProvider>(context).isDarkTheme
                  ? Icons.brightness_7
                  : Icons.brightness_2,
            ),
          ),
          CardWidget(
            text: AppLocalizations.of(context)!.language,
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            widget: Switch(
              activeColor: Theme.of(context).scaffoldBackgroundColor,
              value: _isEnglishSelected,
              onChanged: (newValue) {
                setState(() {
                  _isEnglishSelected = newValue;
                  _onLanguageSelected(newValue);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CardWidget extends StatelessWidget {
  CardWidget(
      {super.key,
      required this.text,
      required this.onTap,
      required this.widget});
  Function() onTap;
  String text;
  Widget widget;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 8.h,
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(text,
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      )),
                  widget
                ],
              ),
            ),
          )),
    );
  }
}

class LanguageContainerWidget extends StatelessWidget {
  const LanguageContainerWidget({
    super.key,
    required this.widget,
    required this.language,
    required this.cCode,
    required this.onLanguageSelected,
  });

  final ProfilePage widget;
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
// CardWidget(
//             text: 'Change Language',
//             onTap: () {
//               setState(() {
//                 _isEnglishSelected = !_isEnglishSelected;
//                 // Dil değişikliğini burada yapabiliriz.
//                 // Örneğin, dil değişkenini kullanarak bir metin dizesi gösterebiliriz.
//               });
//             },
//             icon: Icons.language,
//           ),