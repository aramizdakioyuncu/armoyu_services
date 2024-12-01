import 'package:armoyu_services/core/models/ARMOYU/group.dart';
import 'package:auth_process/app/services/armoyu.dart';
import 'package:auth_process/app/utils/app_list.dart';

import 'package:get/get.dart';

class GroupController extends GetxController {
  var groupsfetchStatus = false.obs;

  var newsList = <Group>[].obs;

  fetchgroups() async {
    groupsfetchStatus.value = true;
    List<Group> response = await ARMOYU.service.groupServices.groupList(
      username: AppList.user.value!.username!,
      password: AppList.user.value!.password!,
      // category: 5,
      page: 1,
    );

    newsList.addAll(response);

    groupsfetchStatus.value = false;
  }
}
