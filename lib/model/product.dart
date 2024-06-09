import 'dart:convert';
import 'package:flutter/services.dart';

class Recipe {
  final String name;
  final String category;
  final String image;
  final String description;

  Recipe({
    required this.name,
    required this.category,
    required this.image,
    required this.description,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      category: json['category'],
      image: json['image'],
      description: json['description'],
    );
  }
}

class RecipeService {
  static Future<List<Recipe>> loadRecipes(String languageCode) async {
    String jsonString = await rootBundle.loadString('assets/lang/$languageCode.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    List<dynamic> recipesJson = jsonMap['recipes'];

    return recipesJson.map((json) => Recipe.fromJson(json)).toList();
  }
}
