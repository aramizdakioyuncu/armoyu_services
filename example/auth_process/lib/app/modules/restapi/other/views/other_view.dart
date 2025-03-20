import 'dart:developer';

import 'package:armoyu_services/core/models/ARMOYU/API/chat/chat_list.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/group/group_room.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/group/group_room_chat.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/rules/rules.dart';
import 'package:armoyu_services/core/models/ARMOYU/_response/response.dart';
import 'package:armoyu_services/core/models/ARMOYU/_response/service_result.dart';
import 'package:auth_process/app/services/armoyu.dart';
import 'package:flutter/material.dart';

class OtherView extends StatelessWidget {
  const OtherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ARMOYU.widgets.elevatedButton.costum1(
                    text: "sitemesaji",
                    onPressed: () async {
                      await ARMOYU.service.appServices.sitemesaji();
                    },
                    loadingStatus: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ARMOYU.widgets.elevatedButton.costum1(
                    text: "text",
                    onPressed: () {},
                    loadingStatus: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ARMOYU.widgets.elevatedButton.costum1(
                    text: "Kurallar",
                    onPressed: () async {
                      RulesResponse response =
                          await ARMOYU.service.rulesServices.fetch(page: 1);
                      for (APIRules element in response.response!) {
                        log(element.toJson().toString());
                      }
                    },
                    loadingStatus: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ARMOYU.widgets.elevatedButton.costum1(
                    text: "Hakkımızda",
                    onPressed: () async {
                      ServiceResult response =
                          await ARMOYU.service.aboutServices.fetch(page: 1);
                      log(response.descriptiondetail);
                    },
                    loadingStatus: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ARMOYU.widgets.elevatedButton.costum1(
                    text: "İstatistikler",
                    onPressed: () async {
                      StatisticsListResponse response = await ARMOYU
                          .service.statisticsServices
                          .fetch(category: "oturumkayitlari");

                      if (!response.result.status) {
                        return;
                      }

                      for (var ee in response.response!) {
                        log(ee.days.toJson().toString());
                        log(ee.hours.toJson().toString());
                        log(ee.month.toJson().toString());
                      }
                    },
                    loadingStatus: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ARMOYU.widgets.elevatedButton.costum1(
                    text: "Chat New List (Friends)",
                    onPressed: () async {
                      ChatNewListResponse response = await ARMOYU
                          .service.chatServices
                          .newChatlist(page: 1);

                      if (!response.result.status) {
                        return;
                      }

                      for (APIChatList ee in response.response!) {
                        log(ee.toJson().toString());
                      }
                    },
                    loadingStatus: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ARMOYU.widgets.elevatedButton.costum1(
                    text: "Chat List (CurrentChat)",
                    onPressed: () async {
                      ChatListResponse response = await ARMOYU
                          .service.chatServices
                          .currentChatList(page: 1);

                      if (!response.result.status) {
                        return;
                      }

                      for (APIChatList ee in response.response!) {
                        log(ee.toJson().toString());
                      }
                    },
                    loadingStatus: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ARMOYU.widgets.elevatedButton.costum1(
                    text: "Group Rooms",
                    onPressed: () async {
                      GroupRoomsResponse response =
                          await ARMOYU.service.groupServices.groupRoomsFetch(
                        groupID: 1,
                      );

                      if (!response.result.status) {
                        return;
                      }

                      for (GroupRoom ee in response.response!) {
                        log(ee.toJson().toString());
                      }
                    },
                    loadingStatus: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ARMOYU.widgets.elevatedButton.costum1(
                    text: "Group Room Chats",
                    onPressed: () async {
                      GroupRoomChatsResponse response =
                          await ARMOYU.service.groupServices.groupRoomChats(
                        roomID: 1,
                      );

                      if (!response.result.status) {
                        return;
                      }

                      for (GroupRoomChat ee in response.response!) {
                        log(ee.toJson().toString());
                      }
                    },
                    loadingStatus: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ARMOYU.widgets.elevatedButton.costum1(
                    text: "Group Room Chats Send",
                    onPressed: () async {
                      GroupRoomChatsSendResponse response =
                          await ARMOYU.service.groupServices.groupRoomChatSend(
                        roomID: 1,
                        content: "adsfas",
                      );

                      if (!response.result.status) {
                        return;
                      }
                      log(response.response!.toJson().toString());
                    },
                    loadingStatus: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ARMOYU.widgets.elevatedButton.costum1(
                    text: "Group Create Room ",
                    onPressed: () async {
                      GroupCreateRoomResponse response =
                          await ARMOYU.service.groupServices.groupRoomCreate(
                              groupID: 1, roomName: "oda adı", roomLimit: 2);

                      if (!response.result.status) {
                        return;
                      }
                      log(response.response!.toJson().toString());
                    },
                    loadingStatus: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ARMOYU.widgets.elevatedButton.costum1(
                    text: "Group Delete Room ",
                    onPressed: () async {
                      ServiceResult response = await ARMOYU
                          .service.groupServices
                          .groupRoomDelete(roomID: 1);

                      if (!response.status) {
                        return;
                      }
                      log(response.description.toString());
                    },
                    loadingStatus: false,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
