import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yemek_ustasi/model/product.dart';
import 'package:yemek_ustasi/view/product/recipe_detail_page.dart';

class ProductPage extends StatefulWidget {
  final Locale currentLocale;

  const ProductPage({super.key, required this.currentLocale});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
      body: FutureBuilder<List<Recipe>>(
        future: loadRecipeListJson(
            widget.currentLocale), // Asenkron işlemi başlatıyoruz
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Veri yüklenirken loading gösterebiliriz
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Eğer bir hata oluştuysa hata mesajını gösteririz
            return Text('Error: ${snapshot.error}');
          } else {
            // Veri başarıyla yüklendiğinde listeyi gösteririz
            final List<Recipe> recipes = snapshot.data!;
            return Expanded(
              child: ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[
                      index]; //recipes listesi index halinde herbir eleman içn ayrı ayrı yazmamak adına bir değişikene atama yapılır
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            //detay sayfasına gitme route
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecipeDetailScreen(
                                      recipe: recipe,
                                    )));
                      },
                      child: Card(
                        child: ListTile(
                          leading: Image.network(
                            //Yemeğin resmi
                            recipes[index].image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(recipes[index].name), //Yemek adı
                          subtitle:
                              Text(recipes[index].category), //Yemek kategorisi
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  // Asenkron işlem için fonksiyonumuzu düzenliyoruz
  static Future<List<Recipe>> loadRecipeListJson(Locale locale) async {
    // JSON dosyasını yükle
    String jsonString =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');

    // JSON verisini dönüştür
    final List<dynamic> parsed = json.decode(jsonString);

    // Dönüştürülen JSON verisini Recipe listesine dönüştürmek için map işlemini kullanıyoruz
    List<Recipe> recipes =
        parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();

    return recipes;
  }
}
