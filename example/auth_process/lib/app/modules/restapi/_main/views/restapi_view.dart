import 'package:armoyu_services/armoyu_services.dart';
import 'package:auth_process/app/modules/restapi/_main/controllers/restapi_controller.dart';
import 'package:auth_process/app/services/armoyu.dart';
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
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ARMOYU.widgets.elevatedButton.costum1(
                    text: "Login",
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
                    enabled: false,
                    onPressed: () async {
                      controller.registerstaus.value = true;
                      await controller.register(
                        firstname: "TEST1",
                        lastname: "SOYAD2",
                        email: "tesst@ema32il.com",
                        password: "12345678",
                        username: "test23",
                      );
                      controller.registerstaus.value = false;
                    },
                    loadingStatus: controller.registerstaus.value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ARMOYU.widgets.elevatedButton.costum1(
                    text: "News",
                    onPressed: () async {
                      Get.toNamed("/restapi/news");
                    },
                    loadingStatus: controller.addfriendstaus.value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ARMOYU.widgets.elevatedButton.costum1(
                    text: "Friends",
                    enabled: false,
                    onPressed: () async {
                      controller.addfriendstaus.value = true;

                      await controller.befriend();
                      controller.addfriendstaus.value = false;
                    },
                    loadingStatus: controller.addfriendstaus.value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ARMOYU.widgets.elevatedButton.costum1(
                    text: "Search Engine",
                    onPressed: () async {
                      Get.toNamed("/restapi/search-engine");
                    },
                    loadingStatus: controller.addfriendstaus.value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ARMOYU.widgets.elevatedButton.costum1(
                    text: "Other",
                    onPressed: () async {
                      Get.toNamed("/restapi/other");
                    },
                    loadingStatus: controller.addfriendstaus.value,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
