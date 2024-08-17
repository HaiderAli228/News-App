import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news/resources/app_color.dart';
import 'package:news/utils/reused_widgets/drawer_tile.dart';
import 'package:news/utils/reused_widgets/news_tile.dart';
import 'package:news/utils/reused_widgets/shimmer_effect.dart';
import 'package:news/utils/routes/routes_names.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../model/get_api_model.dart';
import '../services/response/api_status.dart';
import '../utils/routes/routes.dart';
import '../view_model/home_view_model.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<HomeViewModel>(context, listen: false).fetchGetApiData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: CircleAvatar(
              backgroundColor: AppColors.iconBackgroundColor,
              child: const Icon(Icons.notifications_active_outlined),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 6),
            child: InkWell(
              onTap: () {
                NavigationService.navigateWithTransition(
                    context, RoutesNames.discoverScreenView);
              },
              child: CircleAvatar(
                backgroundColor: AppColors.iconBackgroundColor,
                child: const Icon(Icons.arrow_forward_ios_sharp),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: AppColors.iconBackgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/images/5.jpg"),
                ),
                accountName: Text(
                  "Haider Ali",
                  style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
                ),
                accountEmail: Text(
                  "flutter2830@gmail.com",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              DrawerTile().tile(context, "Home", Icons.home),
              DrawerTile().tile(context, "Setting", Icons.settings),
              DrawerTile().tile(context, "Setting", Icons.settings),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Breaking News",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins"),
                ),
                TextButton(
                  onPressed: () {
                    NavigationService.navigateWithTransition(
                        context, RoutesNames.discoverScreenView);
                  },
                  child: const Text(
                    "View all",
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.28,
            child: Consumer<HomeViewModel>(
              builder: (context, value, child) {
                switch (value.getApiData.status) {
                  case ApiStatus.apiStatusLoading:
                    return ShimmerEffect.shimmerEffectHeading();
                  case ApiStatus.apiStatusComplete:
                    var data = value.getApiData.data;
                    if (data != null &&
                        data.articles != null &&
                        data.articles!.isNotEmpty) {
                      return Stack(
                        children: [
                          CarouselSlider.builder(
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.25,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              onPageChanged: (index, reason) {
                                value.updateCarouselIndex(index);
                              },
                            ),
                            itemCount: data.articles!.length,
                            itemBuilder: (context, index, realIdx) {
                              var article = data.articles![index];
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Image.network(
                                            article.urlToImage ??
                                                'assets/images/1.jpg',
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                'assets/images/1.jpg',
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.black
                                                        .withOpacity(0.7),
                                                    Colors.transparent,
                                                  ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                ),
                                              ),
                                              child: ListTile(
                                                title: Text(
                                                  article.title ?? 'No Title',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Poppins",
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  article.author ??
                                                      'Unknown Author',
                                                  style: const TextStyle(
                                                    color: Colors.white70,
                                                    fontFamily: "Poppins",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: AnimatedSmoothIndicator(
                                activeIndex: value.carouselCurrentIndex,
                                count: data.articles!.length,
                                effect: ExpandingDotsEffect(
                                  dotHeight: 10,
                                  dotWidth: 10,
                                  activeDotColor: Colors.blue,
                                  dotColor: Colors.grey.shade400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: Text('No articles found.'));
                    }

                  case ApiStatus.apiStatusError:
                    return Center(
                        child: Text(value.getApiData.message.toString()));
                  default:
                    return const Center(child: Text('Unexpected state'));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recommendation",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins"),
                ),
                TextButton(
                  onPressed: () {
                    NavigationService.navigateWithTransition(
                        context, RoutesNames.discoverScreenView);
                  },
                  child: const Text(
                    "View all",
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<HomeViewModel>(
              builder: (context, value, child) {
                switch (value.getApiData.status) {
                  case ApiStatus.apiStatusLoading:
                    return ShimmerEffect.shimmerEffect();
                  case ApiStatus.apiStatusComplete:
                    var data = value.getApiData.data;
                    if (data != null &&
                        data.articles != null &&
                        data.articles!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: data.articles!.length,
                        itemBuilder: (context, index) {
                          Articles article = data.articles![index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: NewsTile(
                              newsTitle: article.title ?? 'No Title',
                              newPicture: article.urlToImage ?? "",
                              userName: article.author,
                              userPicture: article.urlToImage,
                              newTime: article.publishedAt,
                              onTap: () {
                                NavigationService.navigateWithTransition(
                                  context,
                                  RoutesNames.explainMoreScreenView,
                                  article: article,
                                );
                              },
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('No articles found.'));
                    }
                  case ApiStatus.apiStatusError:
                    return Center(
                        child: Text(value.getApiData.message.toString()));
                  default:
                    return const Center(child: Text('Unexpected state'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
