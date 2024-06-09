import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../view/product/product_page.dart';
import '../view/home/home_page.dart';
import '../view/profile/profile.dart';

class NavigationBarPage extends StatefulWidget {
  final Locale currentLocale;
  final void Function(Locale) changeLocale;
  const NavigationBarPage(
      {super.key, required this.currentLocale, required this.changeLocale});
  @override
  // ignore: library_private_types_in_public_api
  _NavigationBarPageState createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePage(),
      ProductPage(currentLocale: widget.currentLocale),
      ProfilePage(
        changeLocale: widget.changeLocale, // Dil değişim fonksiyonu
        currentLocale: widget.currentLocale, // Mevcut dil
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.home_page,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.food_bank),
            label: AppLocalizations.of(context)!.recipes,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).scaffoldBackgroundColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
