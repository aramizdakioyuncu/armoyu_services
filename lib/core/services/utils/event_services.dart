part of 'package:armoyu_services/armoyu_services.dart';

class EventServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  EventServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  Future<EventResponse> fetch() async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {},
      endpoint: "0/0/${_EndpointConstants.eventlist}/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    EventResponse armoyuresponse = EventResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    List<APIEvent> eventlist = [];
    for (var element in response['icerik']) {
      List<UserInfo> organizerlist = [];

      for (var element2 in element['event_organizer']) {
        organizerlist.add(
          UserInfo(
            userID: element2['player_ID'],
            displayname: element2['player_displayname'],
            avatar: MediaURL(
              bigURL: element2['player_avatar'],
              normalURL: element2['player_avatar'],
              minURL: element2['player_avatar'],
            ),
          ),
        );
      }
      eventlist.add(
        APIEvent(
          eventID: element['event_ID'],
          status: element['event_ID'],
          link: element['event_ID'],
          foto: element['event_ID'],
          fotoDetail: element['event_ID'],
          name: element['event_ID'],
          gameID: element['event_ID'],
          gameName: element['event_ID'],
          gameBanner: element['event_ID'],
          gameLogo: element['event_ID'],
          organizer: organizerlist,
          type: element['event_ID'],
          date: element['event_ID'],
          participantType: element['event_ID'],
          participantLimit: element['event_ID'],
          participantGroupPlayerLimit: element['event_ID'],
          participantCurrent: element['event_ID'],
          location: element['event_ID'],
          description: element['event_ID'],
          rules: element['event_ID'],
        ),
      );
    }
    armoyuresponse.response = eventlist;
    return armoyuresponse;
  }

  Future<EventDetailResponse> detailfetch({required int eventID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      endpoint: "0/0/${_EndpointConstants.eventdetail}/$eventID/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    EventDetailResponse armoyuresponse = EventDetailResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    armoyuresponse.response = APIEventDetail(
      eventName: response['icerik']['event_name'],
      eventDate: response['icerik']['event_date'],
      dlc: response['icerik']['dlc'],
      files: response['icerik']['files'],
      detail: response['icerik']['detail'],
    );
    return armoyuresponse;
  }

  Future<EventJoinorLeaveResponse> joinOrleave({
    required int eventID,
    required bool status,
  }) async {
    int intStatus = 0;

    if (status) {
      intStatus = 1;
    }

    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "etkinlikID": "$eventID",
        "cevap": intStatus,
      },
      endpoint: "0/0/${_EndpointConstants.joinleave}/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    EventJoinorLeaveResponse armoyuresponse =
        EventJoinorLeaveResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }
    return armoyuresponse;
  }

  Future<EventParticipantResponse> participantList({
    required int eventID,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "etkinlikID": "$eventID",
      },
      endpoint: "0/0/${_EndpointConstants.participant}/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    EventParticipantResponse armoyuresponse =
        EventParticipantResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    List<APIEventparticipantGroups> grouplist = [];
    List<UserInfo> playerlist = [];

    for (var element in response['icerik']['participant_groups']) {
      List<UserInfo> groupPlayers = [];
      for (var element2 in element['group_players']) {
        groupPlayers.add(UserInfo(
          userID: element2['player_ID'],
          username: element2['player_username'],
          displayname: element2['player_name'],
          role: element2['player_role'],
          avatar: MediaURL(
            bigURL: element2['player_avatar'],
            normalURL: element2['player_avatar'],
            minURL: element2['player_avatar'],
          ),
        ));
      }

      grouplist.add(
        APIEventparticipantGroups(
          groupID: element['group_ID'],
          groupName: element['group_ID'],
          groupShortname: element['group_ID'],
          groupLogo: element['group_ID'],
          groupBanner: element['group_ID'],
          groupURL: element['group_ID'],
          groupPlayers: groupPlayers,
        ),
      );
    }

    for (var element in response['icerik']['participant_players']) {
      playerlist.add(
        UserInfo(
          userID: element['player_ID'],
          username: element['player_username'],
          displayname: element['player_name'],
          avatar: MediaURL(
            bigURL: element['player_avatar'],
            normalURL: element['player_avatar'],
            minURL: element['player_avatar'],
          ),
        ),
      );
    }
    armoyuresponse.response = APIEventParticipant(
      groups: grouplist,
      players: playerlist,
    );
    return armoyuresponse;
  }
}
