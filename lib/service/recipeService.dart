import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:yemek_ustasi/model/product.dart';

class RecipeService {
  static Future<List<Recipe>> loadRecipeListJson(String locale) async {
    // JSON dosyasını yükle
    String jsonString =
        await rootBundle.loadString('assets/$locale.json');//json yolu

    // JSON verisini dönüştür
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();

    // Her bir JSON öğesini Recipe nesnesine dönüştür
    List<Recipe> recipes =
        parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();

    return recipes;
  }
}
