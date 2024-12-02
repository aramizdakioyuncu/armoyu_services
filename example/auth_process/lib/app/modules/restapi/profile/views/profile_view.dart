import 'package:auth_process/app/modules/restapi/profile/controllers/profile_controller.dart';
import 'package:auth_process/app/services/armoyu.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 180.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ARMOYU.widgets.textField.costum3(
                      controller: controller.userIDController.value,
                      title: "User ID",
                      onChanged: (val) {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Obx(
                    () => ARMOYU.widgets.elevatedButton.costum1(
                      text: "Fetch Profile",
                      onPressed: () => controller.lookprofile(),
                      loadingStatus: controller.proccessStatus.value,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ARMOYU.widgets.textField.costum3(
                      controller: controller.usernameController.value,
                      title: "Username",
                      onChanged: (val) {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Obx(
                    () => ARMOYU.widgets.elevatedButton.costum1(
                      text: "Fetch Profile with username",
                      onPressed: () => controller.lookprofilewithusername(),
                      loadingStatus: controller.proccessStatus.value,
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => controller.user.value == null
                  ? Container()
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CircleAvatar(
                              foregroundImage: CachedNetworkImageProvider(
                                controller.user.value!.avatar!.mediaURL.minURL,
                              ),
                              radius: 50,
                            ),
                            Text(controller.user.value!.displayName!),
                          ],
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
