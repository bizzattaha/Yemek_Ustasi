import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> bannerImages = [
    //banner image list
    'https://www.bakpilic.com.tr/images/slider/slider-2_1669039009.png',
    'https://www.hasata.com.tr/Data/BlockUploadData/slider/img1/925/tarif-sayfas--banner-1-tr.jpg?1712320032',
    'https://mmbocekanadolulisesi.meb.k12.tr/meb_iys_dosyalar/07/20/759956/resimler/2023_09/k_15182338_03153016_yemekmenusu.jpg',
    'https://images.themagger.net/wp-content/uploads/2018/11/yemek-tarifi-uygulamalari-633x433.jpg'
  ];

  final List<Map<String, String>> popularRecipes = [
    //tarifler listesi
    {
      'title': 'İmam Bayıldı',
      'image':
          'https://i.nefisyemektarifleri.com/2023/08/18/imam-bayildi-yapimi-8.jpg',
      'category': 'Ana Yemek'
    },
    {
      'title': 'Manti',
      'image':
          'https://i.lezzet.com.tr/images-xxlarge-secondary/manti-nasil-pisirilir-9853d099-517c-4e89-be1c-960b703dcb8e.jpg',
      'category': 'Ana Yemek'
    },
    {
      'title': 'Baklava',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOZXiloEaQVE_zTaetvmBb_rz4l47No94XBw&s',
      'category': 'Tatlı'
    },
  ];

  final List<String> categories = [
    'main_course',
    'Tatlı',
    'Salata',
    'Çorba',
  ];

  String getGreetingMessage(
      String gMorning, String gAfternoon, String gEvening, String gNight) {
    final hour = DateTime.now().hour; //günün saatlik olarak dilimini çek

    if (hour < 12) {
      return gMorning;
    } else if (hour < 18) {
      return gAfternoon;
    } else if (hour < 20) {
      return gEvening;
    } else {
      return gNight;
    }
  }

  String greetingMessage = '';

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback kullanarak `context`'i güvenli bir şekilde kullanma
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        greetingMessage = getGreetingMessage(
          AppLocalizations.of(context)!.gMorning,
          AppLocalizations.of(context)!.gAfternoon,
          AppLocalizations.of(context)!.gEvening,
          AppLocalizations.of(context)!.gNight,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          AppLocalizations.of(context)!.home_page,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  //Hoş geldiniz fonksiyonu
                  '$greetingMessage,${AppLocalizations.of(context)!.welcome}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              // Banner Slider
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: bannerImages.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              // Popular Recipes Section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.popular_recipes,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularRecipes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    popularRecipes[index]['image']!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(popularRecipes[index]['title']!),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              // Categories Section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.categories,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              // Container(
              //   height: 60,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: categories.length,
              //     itemBuilder: (context, index) {
              //       return Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Chip(
              //           label: Text(categories[index]),
              //           backgroundColor: Colors.orangeAccent,
              //         ),
              //       );
              //     },
              //   ),
              // ),
              SingleChildScrollView(
                //taşma hatası giderilsin ve sayfada kaydırma yapsın
                scrollDirection: Axis.horizontal, //yataya doğru scroll olsun
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.h),
                  child: Row(
                    children: [
                      Chip(
                        label: Text(
                          AppLocalizations.of(context)!.main_course,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 2.h,
                      ),
                      Chip(
                        label: Text(
                          AppLocalizations.of(context)!.desserts,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 2.h,
                      ),
                      Chip(
                        label: Text(
                          AppLocalizations.of(context)!.salads,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 2.h,
                      ),
                      Chip(
                        label: Text(
                          AppLocalizations.of(context)!.soups,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
