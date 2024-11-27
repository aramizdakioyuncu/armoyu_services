import 'package:auth_process/app/modules/restapi/searchengine/controllers/search_engine_controller.dart';
import 'package:auth_process/app/services/armoyu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchEngineView extends StatelessWidget {
  const SearchEngineView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchEngineController());
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 180.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => ARMOYU.widgets.textField.costum3(
                  controller: controller.searchController.value,
                  maxLength: 41,
                  minLength: 10,
                  onChanged: (val) {
                    controller.searchQuery.value = val;
                    controller.searchController.refresh();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
