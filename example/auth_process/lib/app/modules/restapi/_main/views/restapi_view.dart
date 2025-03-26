import 'package:armoyu_services/armoyu_services.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/post/post_detail.dart';
import 'package:armoyu_services/core/models/ARMOYU/_response/response.dart';
import 'package:armoyu_widgets/widget.dart';
import 'package:auth_process/app/modules/restapi/_main/controllers/restapi_controller.dart';
import 'package:auth_process/app/services/armoyu.dart';
import 'package:auth_process/app/utils/app_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestapiView extends StatelessWidget {
  const RestapiView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RestapiController(), permanent: true);

    return Scaffold(
      appBar: AppBar(title: const Text("Rest API Example")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80.0),
            child: Row(
              children: [
                Obx(
                  () => controller.statusController.value == null
                      ? Container()
                      : controller.statusController.value!
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                ),
                Expanded(
                  child: Obx(
                    () => ARMOYU.widgets.textField.costum3(
                      controller: controller.apikeyController.value,
                      minLength: 25,
                      maxLength: 35,
                      title: "API KEY ",
                      placeholder: ARMOYU.service.apiKey,
                      onChanged: (val) {
                        //Important for state
                        controller.apikeyController.refresh();
                        controller.statusController.value = null;
                      },
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.statusController.value == null,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ARMOYU.widgets.elevatedButton.costum1(
                        text: "KAYDET",
                        onPressed: () async {
                          controller.savestaus.value = true;
                          ARMOYU.service = ARMOYUServices(
                            apiKey: controller.apikeyController.value.text,
                            usePreviousAPI: true,
                          );
                          ARMOYU.widgets =
                              ARMOYUWidget(service: ARMOYU.service);

                          bool status = await ARMOYU.service.setup();
                          controller.statusController.value = status;

                          controller.savestaus.value = false;
                        },
                        loadingStatus: controller.savestaus.value,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => controller.statusController.value == null
                  ? Container()
                  : Obx(
                      () => Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ARMOYU.widgets.elevatedButton.costum1(
                              text: "Login",
                              enabled: controller.statusController.value!,
                              onPressed: () async {
                                Get.toNamed("/restapi/login");
                              },
                              loadingStatus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ARMOYU.widgets.elevatedButton.costum1(
                              text: "Register",
                              enabled: controller.statusController.value!,
                              onPressed: () async {
                                Get.toNamed("/restapi/register");
                              },
                              loadingStatus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ARMOYU.widgets.elevatedButton.costum1(
                              text: "Profile",
                              enabled: controller.statusController.value! &&
                                  AppList.user.value != null,
                              onPressed: () async {
                                Get.toNamed("/restapi/profile");
                              },
                              loadingStatus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ARMOYU.widgets.elevatedButton.costum1(
                              text: "News",
                              enabled: controller.statusController.value! &&
                                  AppList.user.value != null,
                              onPressed: () async {
                                Get.toNamed("/restapi/news");
                              },
                              loadingStatus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ARMOYU.widgets.elevatedButton.costum1(
                              text: "Friends",
                              enabled: controller.statusController.value! &&
                                  AppList.user.value != null,
                              onPressed: () async {},
                              loadingStatus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ARMOYU.widgets.elevatedButton.costum1(
                              text: "Search Engine",
                              enabled: controller.statusController.value! &&
                                  AppList.user.value != null,
                              onPressed: () async {
                                Get.toNamed("/restapi/search-engine");
                              },
                              loadingStatus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ARMOYU.widgets.elevatedButton.costum1(
                              text: "Other",
                              enabled: controller.statusController.value! &&
                                  AppList.user.value != null,
                              onPressed: () async {
                                Get.toNamed("/restapi/other");
                              },
                              loadingStatus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ARMOYU.widgets.elevatedButton.costum1(
                              text: "Groups",
                              enabled: controller.statusController.value! &&
                                  AppList.user.value != null,
                              onPressed: () async {
                                Get.toNamed("/restapi/groups");
                              },
                              loadingStatus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ARMOYU.widgets.elevatedButton.costum1(
                              text: "Gallery",
                              enabled: controller.statusController.value! &&
                                  AppList.user.value != null,
                              onPressed: () async {
                                Get.toNamed("/restapi/gallery");
                              },
                              loadingStatus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ARMOYU.widgets.elevatedButton.costum1(
                              text: "getPosts",
                              enabled: controller.statusController.value! &&
                                  AppList.user.value != null,
                              onPressed: () async {
                                PostFetchListResponse response = await ARMOYU
                                    .service.postsServices
                                    .getPosts(page: 1);

                                for (APIPostList element
                                    in response.response!) {
                                  log(element.toJson().toString());
                                }
                              },
                              loadingStatus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ARMOYU.widgets.elevatedButton.costum1(
                              text: "piyasa (Kur)",
                              enabled: controller.statusController.value! &&
                                  AppList.user.value != null,
                              onPressed: () async {
                                ForeignCurrencyListResponse aa = await ARMOYU
                                    .service.utilsServices
                                    .foreigncurrencylist(page: 1);

                                for (var element in aa.response!) {
                                  log(element.value);
                                }
                              },
                              loadingStatus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ARMOYU.widgets.elevatedButton.costum1(
                              text: "hava durumu",
                              enabled: controller.statusController.value! &&
                                  AppList.user.value != null,
                              onPressed: () async {
                                WeatherListResponse aa = await ARMOYU
                                    .service.utilsServices
                                    .weatherlist(page: 1);

                                for (var element in aa.response!) {
                                  log(element.city);
                                }
                              },
                              loadingStatus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ARMOYU.widgets.elevatedButton.costum1(
                              text: "İndirimdeki Oyunlar",
                              enabled: controller.statusController.value! &&
                                  AppList.user.value != null,
                              onPressed: () async {
                                GamesOnSaleResponse aa = await ARMOYU
                                    .service.utilsServices
                                    .gamesOnSale(page: 1);

                                for (var element in aa.response!) {
                                  log(element.gameName);
                                }
                              },
                              loadingStatus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ARMOYU.widgets.elevatedButton.costum1(
                              text: "Yeni Kayıt Olanlar",
                              enabled: controller.statusController.value! &&
                                  AppList.user.value != null,
                              onPressed: () async {
                                NewRegisteredUsersResponse aa = await ARMOYU
                                    .service.utilsServices
                                    .newRegisterUsers(page: 1);

                                for (var element in aa.response!) {
                                  log(element.displayname);
                                }
                              },
                              loadingStatus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ARMOYU.widgets.elevatedButton.costum1(
                              text: "Minecraft İstatistik",
                              enabled: controller.statusController.value! &&
                                  AppList.user.value != null,
                              onPressed: () async {
                                MinecraftStatisticsResponse aa = await ARMOYU
                                    .service.utilsServices
                                    .minecraftStatistics(page: 1);

                                for (var element in aa.response!) {
                                  log("${element.playername} ${element.clanname}");
                                }
                              },
                              loadingStatus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ARMOYU.widgets.elevatedButton.costum1(
                              text: "Etkinlikler",
                              enabled: controller.statusController.value! &&
                                  AppList.user.value != null,
                              onPressed: () async {
                                Get.toNamed("/restapi/events");
                              },
                              loadingStatus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ARMOYU.widgets.elevatedButton.costum1(
                              text: "Kontrol Paneli",
                              enabled: controller.statusController.value! &&
                                  AppList.user.value != null,
                              onPressed: () async {
                                Get.toNamed("/restapi/controlpanel");
                              },
                              loadingStatus: false,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
