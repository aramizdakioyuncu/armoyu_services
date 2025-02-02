import 'dart:developer';

import 'package:armoyu_services/armoyu_services.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/controlpanel/controlpanel_meetinglist.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/controlpanel/controlpanel_userslist.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/crew/crew_list.dart';
import 'package:armoyu_services/core/models/ARMOYU/_response/response.dart';
import 'package:auth_process/app/services/armoyu.dart';
import 'package:flutter/material.dart';

class ControlpanelView extends StatelessWidget {
  const ControlpanelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ARMOYU.widgets.elevatedButton.costum1(
                text: "Home",
                onPressed: () async {
                  ControlPanelHomeResponse response =
                      await ARMOYU.service.controlpanelServices.home();
                  if (!response.result.status) {
                    log(response.result.description);
                    return;
                  }
                  for (APIControlpanelUserslist element in response.response!) {
                    log(element.toJson().toString());
                  }
                },
                loadingStatus: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ARMOYU.widgets.elevatedButton.costum1(
                text: "Meeting",
                onPressed: () async {
                  ControlPanelMeetingResponse response =
                      await ARMOYU.service.controlpanelServices.meeting();
                  if (!response.result.status) {
                    log(response.result.description);
                    return;
                  }
                  for (APIControlpanelMeetinglist element
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
                text: "Crew",
                onPressed: () async {
                  CrewResponse response =
                      await ARMOYU.service.crewServices.fetch(page: 1);
                  if (!response.result.status) {
                    log(response.result.description);
                    return;
                  }
                  for (APICrewList element in response.response!) {
                    log(element.toJson().toString());
                  }
                },
                loadingStatus: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
