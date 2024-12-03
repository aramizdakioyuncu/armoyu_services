import 'package:armoyu_services/core/models/ARMOYU/API/group/group_list.dart';
import 'package:armoyu_services/core/models/ARMOYU/_response/response.dart';
import 'package:auth_process/app/services/armoyu.dart';

import 'package:get/get.dart';

class GroupController extends GetxController {
  var groupsfetchStatus = false.obs;

  var newsList = <APIGroupListDetail>[].obs;

  fetchgroups() async {
    groupsfetchStatus.value = true;
    GroupListResponse response = await ARMOYU.service.groupServices.groupList(
      // category: 5,
      page: 1,
    );

    newsList.addAll(response.response!.groups);

    groupsfetchStatus.value = false;
  }
}
