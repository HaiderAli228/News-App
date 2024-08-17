import 'package:flutter/material.dart';
import 'package:news/utils/reused_widgets/filter_chip_button.dart';
import 'package:news/utils/reused_widgets/news_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/get_api_model.dart';
import '../services/response/api_status.dart';
import '../utils/reused_widgets/shimmer_effect.dart';
import '../utils/routes/routes.dart';
import '../utils/routes/routes_names.dart';
import '../view_model/home_view_model.dart';
class DiscoverMoreViewScreen extends StatefulWidget {
  const DiscoverMoreViewScreen({super.key});

  @override
  State<DiscoverMoreViewScreen> createState() => _DiscoverMoreViewScreenState();
}

class _DiscoverMoreViewScreenState extends State<DiscoverMoreViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leadingWidth: 75,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: const Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 33,
              color: Colors.black,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 18, top: 10),
              child: Text(
                "Discover",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  fontSize: 30,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 0),
              child: Text(
                "News From All World",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(CupertinoIcons.slider_horizontal_3),
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.search, color: Colors.grey),
                  ),
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(
                    width: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: FilterChip(
                      label: const Text(
                        "All",
                        style: TextStyle(color: Colors.white),
                      ),
                      onSelected: (val) {},
                      padding: const EdgeInsets.all(10),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  const FilterChipButton(
                    title: "Politics",
                  ),
                  const FilterChipButton(
                    title: "Sports",
                  ),
                  const FilterChipButton(
                    title: "Education",
                  ),
                  const FilterChipButton(
                    title: "Gaming",
                  ),
                  const FilterChipButton(
                    title: "Engineering",
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
      ),
    );
  }
}
