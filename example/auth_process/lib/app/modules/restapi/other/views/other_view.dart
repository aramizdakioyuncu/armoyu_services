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
                    text: "text",
                    onPressed: () {},
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
