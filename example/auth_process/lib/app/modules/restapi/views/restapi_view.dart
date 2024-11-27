import 'package:armoyu_services/armoyu_services.dart';
import 'package:armoyu_services/widgets/widget.dart';
import 'package:auth_process/app/modules/restapi/controllers/restapi_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestapiView extends StatelessWidget {
  const RestapiView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RestapiController());
    var ccc = TextEditingController().obs;
    ARMOYUWidget widget =
        ARMOYUWidget(service: ARMOYUServices(apiKey: "123123"));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Rest API Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => widget.textField.costum3(
                controller: ccc.value,
                minLength: 100,
                maxLength: 101,
                title: "API KEY ",
                onChanged: (val) {
                  ccc.refresh();
                },
              ),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.elevatedButton.costum1(
                  text: "Test Login",
                  onPressed: () async {
                    controller.loginstaus.value = true;

                    await controller.previuslogin();
                    controller.loginstaus.value = false;
                  },
                  loadingStatus: controller.loginstaus.value,
                ),
              ),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.elevatedButton.costum1(
                  text: "Test Add Friend",
                  onPressed: () async {
                    controller.addfriendstaus.value = true;

                    await controller.befriend();
                    controller.addfriendstaus.value = false;
                  },
                  loadingStatus: controller.addfriendstaus.value,
                ),
              ),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.elevatedButton.costum1(
                  text: "Test Register",
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
            ),
          ],
        ),
      ),
    );
  }
}
