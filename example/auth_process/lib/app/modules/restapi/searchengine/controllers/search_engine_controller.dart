import 'package:armoyu_services/core/models/ARMOYU/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchEngineController extends GetxController {
  var search = SearchController().obs;
  final filteredItems = <User>[].obs;
  final allItems = <User>[].obs;

  final filteredItemsV2 = <User>[];
  final allItemsV2 = <User>[];

  var searchQuery = "".obs;

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();

    // debounce(
    //   searchQuery,
    //   (value) async {
    //     if (value.length < 3) {
    //       return;
    //     }

    //     filteredItems.value = allItems
    //         .where((element) => element.displayname!
    //             .toLowerCase()
    //             .contains(value.toLowerCase()))
    //         .toList();

    //     log(filteredItems.length.toString());
    //     Map<String, dynamic> response = await ARMOYU.service.searchServices
    //         .searchengine(searchword: value, page: 1);

    //     if (response['durum'] == 0) {
    //       log(response['aciklama']);
    //       return;
    //     }

    //     log(response['icerik'].toString());

    //     for (var element in response['icerik']) {
    //       if (!allItems
    //           .any((filterelement) => filterelement.userID == element['ID'])) {
    //         log("Eklemee işlemi");
    //         allItems.add(
    //           User(
    //             userID: element['ID'],
    //             displayname: element['Value'],
    //             avatar: element['avatar'],
    //           ),
    //         );
    //       }
    //     }
    //     filteredItems.value = allItems
    //         .where((element) => element.displayname!
    //             .toLowerCase()
    //             .contains(value.toLowerCase()))
    //         .toList();

    //     filteredItems.refresh();
    //   }, // Yazmayı bırakınca çalışacak fonksiyon
    //   time: const Duration(milliseconds: 500),
    // );
  }
}
