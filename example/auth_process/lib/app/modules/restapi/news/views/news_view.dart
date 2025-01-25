import 'dart:developer';

import 'package:armoyu_services/core/models/ARMOYU/API/news/news_list.dart';
import 'package:auth_process/app/modules/restapi/news/controllers/news_controller.dart';
import 'package:auth_process/app/services/armoyu.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewsController(), permanent: true);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => ARMOYU.widgets.elevatedButton.costum1(
                  text: "Get News",
                  onPressed: () async => controller.fetchnews(),
                  loadingStatus: controller.newsfetchStatus.value,
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => SingleChildScrollView(
                  child: Wrap(
                    children: List.generate(
                      controller.newsList.length,
                      (index) {
                        APINewsDetail newsInfo = controller.newsList[index];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: InkWell(
                            onTap: () async {
                              log(newsInfo.newsURL.split("/")[5]);
                              controller.fetchdetailnews(
                                  newsURL: newsInfo.newsURL.split("/")[5]);
                            },
                            child: Container(
                              height: 300,
                              width: 400,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    newsInfo.media.mediaURL.minURL,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Positioned(
                                bottom: 0,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.5),
                                        Colors.black.withOpacity(0.3),
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "The Witcher 3 Patch 4.01 Güncellemesi",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            color: Colors.lightBlue,
                                            child: const Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: Text(
                                                "OYUN",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color: Colors.lightBlue,
                                            child: const Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: Text(
                                                "BERKAY TİKENOĞLU",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: const FaIcon(
                                                FontAwesomeIcons.twitter,
                                                color: Colors.white,
                                                size: 10,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const FaIcon(
                                                FontAwesomeIcons.facebook,
                                                color: Colors.white,
                                                size: 10,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const FaIcon(
                                                FontAwesomeIcons.whatsapp,
                                                color: Colors.white,
                                                size: 10,
                                              ),
                                            ),
                                            const Spacer(),
                                            const Text(
                                              "551 Görüntülenme , 1 Yıl",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
