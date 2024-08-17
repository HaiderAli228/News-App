import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/get_api_model.dart';

class ExplainMoreScreen extends StatelessWidget {
  final Articles article;
  const ExplainMoreScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          InkWell(
            child: CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.5),
              child: const Icon(
                Icons.turned_in_not,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              child: CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(0.5),
                child: const Icon(
                  Icons.more_horiz,
                  size: 33,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.5),
            child: const Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 33,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black,
                  width: double.infinity,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(article.urlToImage ??
                          'assets/images/1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Semi-transparent overlay
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.31,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4), // Darker overlay
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30,left: 17),
                          child: FilterChip(
                            label: const Text(
                              "Today",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                              ),
                            ),
                            onSelected: (val) {},
                            padding: const EdgeInsets.all(10),
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                        SizedBox(height: 10), // Added spacing
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            article.title ?? 'Heading Here',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Trending . ${article.publishedAt ?? 'Unknown Time'}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.5,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 20, bottom: 13),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    article.urlToImage ??
                                        'assets/images/5.jpg'),
                              ),
                              title: Text(
                                article.author ?? 'Unknown Author',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 22),
                            child: Text(
                              article.description ??
                                  'No Description Available',
                              style: const TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
