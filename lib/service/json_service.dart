import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JsonService {
  static late Map<String, dynamic> _jsonData;

  static Future<void> loadJsonData(BuildContext context) async {
    try {
      String jsonDataString = await rootBundle.loadString('assets/splash/logo.json');//json dosyasının bulunudğu path
      _jsonData = jsonDecode(jsonDataString);//pathten okunan yol decode edilir
    } catch (e) {
      // JSON yükleme hatası
      if (kDebugMode) {
        print('JSON yükleme hatası: $e');
      }
      // Hata mesajını göster
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('JSON verisi yüklenirken bir hata oluştu.'),
        ),
      );
    }
  }

  static String getLogoUrl(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    if (brightness == Brightness.dark) {
      return _jsonData['logoUrl2'];//dark mod ise bu logo
    } else {
      return _jsonData['logoUrl'];//light mod ise bu logo
    }
  }
}
