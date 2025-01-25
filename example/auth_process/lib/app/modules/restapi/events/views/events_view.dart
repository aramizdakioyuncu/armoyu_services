import 'dart:developer';

import 'package:armoyu_services/core/models/ARMOYU/_response/response.dart';
import 'package:auth_process/app/services/armoyu.dart';
import 'package:flutter/material.dart';

class EventsView extends StatelessWidget {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ARMOYU.widgets.elevatedButton.costum1(
          text: "ÇEK",
          onPressed: () async {
            EventDetailResponse response =
                await ARMOYU.service.eventServices.fetchdetail(eventID: 346);
            if (!response.result.status) {
              log(response.result.description);
              return;
            }
            log(response.response!.event.name);
          },
          loadingStatus: false,
        ),
      ),
    );
  }
}
