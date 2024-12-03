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

    armoyuresponse.response = APIEvent(
      eventID: response['icerik']['event_ID'],
      status: response['icerik']['event_ID'],
      link: response['icerik']['event_ID'],
      foto: response['icerik']['event_ID'],
      fotoDetail: response['icerik']['event_ID'],
      name: response['icerik']['event_ID'],
      gameID: response['icerik']['event_ID'],
      gameName: response['icerik']['event_ID'],
      gameBanner: response['icerik']['event_ID'],
      gameLogo: response['icerik']['event_ID'],
      organizer: UserInfo(
        userID: response['icerik']['event_organizer']['player_ID'],
        displayname: response['icerik']['event_organizer']
            ['player_displayname'],
        // username: response['icerik']['event_organizer']['player_ID'],
        avatar: MediaURL(
          bigURL: response['icerik']['event_organizer']['player_avatar'],
          normalURL: response['icerik']['event_organizer']['player_avatar'],
          minURL: response['icerik']['event_organizer']['player_avatar'],
        ),
      ),
      type: response['icerik']['event_ID'],
      date: response['icerik']['event_ID'],
      participantType: response['icerik']['event_ID'],
      participantLimit: response['icerik']['event_ID'],
      participantGroupPlayerLimit: response['icerik']['event_ID'],
      participantCurrent: response['icerik']['event_ID'],
      location: response['icerik']['event_ID'],
      description: response['icerik']['event_ID'],
      rules: response['icerik']['event_ID'],
    );
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
