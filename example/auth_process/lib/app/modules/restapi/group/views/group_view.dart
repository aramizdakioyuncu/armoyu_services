import 'package:armoyu_services/core/models/ARMOYU/API/group/group_list.dart';
import 'package:auth_process/app/modules/restapi/group/controllers/group_controller.dart';
import 'package:auth_process/app/services/armoyu.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class GroupView extends StatelessWidget {
  const GroupView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GroupController());
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => ARMOYU.widgets.elevatedButton.costum1(
                text: "Get Groups",
                onPressed: () async => controller.fetchgroups(),
                loadingStatus: controller.groupsfetchStatus.value,
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => Center(
                child: SingleChildScrollView(
                  child: Wrap(
                    children: [
                      ...List.generate(
                        controller.newsList.length,
                        (index) {
                          APIGroupListDetail groupInfo =
                              controller.newsList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 350,
                              child: Column(
                                children: [
                                  Container(
                                    height: 200,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            groupInfo.banner.mediaURL.minURL,
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed("/gruplar/detail");
                                          },
                                          child: CircleAvatar(
                                            foregroundImage:
                                                CachedNetworkImageProvider(
                                              groupInfo.logo.mediaURL.minURL,
                                            ),
                                            radius: 30,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black38,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              groupInfo.name,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Get.theme.canvasColor,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 100,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Visibility(
                                                visible:
                                                    groupInfo.description !=
                                                        null,
                                                child: Text(
                                                  groupInfo.description
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            leading: const FaIcon(
                                                FontAwesomeIcons.ticket),
                                            title: Text(
                                              groupInfo.shortname,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            leading: const FaIcon(
                                                FontAwesomeIcons.users),
                                            title: Text(
                                              groupInfo.membercount.toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            trailing: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                color: groupInfo.joinable
                                                    ? Colors.green
                                                    : Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    groupInfo.joinable
                                                        ? 'Alım Açık'
                                                        : 'Alım Kapalı',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            leading: const FaIcon(
                                                FontAwesomeIcons.globe),
                                            title: Visibility(
                                              visible:
                                                  groupInfo.socail.website !=
                                                      null,
                                              child: Text(
                                                groupInfo.socail.website
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            leading: const FaIcon(
                                                FontAwesomeIcons.calendar),
                                            title: Text(
                                              groupInfo.registerdate,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            leading: const FaIcon(
                                                FontAwesomeIcons.gear),
                                            title: Text(
                                              "${groupInfo.category}/${groupInfo.categorydetail}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            leading: const FaIcon(
                                                FontAwesomeIcons.gamepad),
                                            title: Visibility(
                                              visible:
                                                  groupInfo.defaultgame != null,
                                              child: Text(
                                                groupInfo.defaultgame
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              child: const Icon(
                                                Icons.discord_rounded,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
