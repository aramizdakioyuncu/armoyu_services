part of 'package:armoyu_services/armoyu_services.dart';

class GroupServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  GroupServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  Future<GroupListResponse> groupList({
    int? category,
    required int page,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"kategori": category ?? "", "sayfa": page},
      endpoint: "0/0/${_EndpointConstants.groups}/liste/0",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    GroupListResponse armoyuresponse = GroupListResponse(result: result);
    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    List<APIGroupListDetail> list = [];
    for (var element in response['icerik']) {
      list.add(
        APIGroupListDetail(
          groupID: element['group_ID'],
          name: element['group_name'],
          shortname: element['group_shortname'],
          registerdate: element['group_registered'],
          membercount: element['group_membercount'],
          category: element['group_category'],
          categorydetail: element['group_categorydetail'],
          defaultgame: element['group_defaultgame'],
          joinable: element['group_joinstatus'] == 1 ? true : false,
          description: element['group_description'],
          socail: GroupSocial(
            website: element['group_social']['group_website'],
            discord: element['group_social']['group_discord'],
          ),
          groupURL: element['group_URL'],
          groupOwner: UserInfo(
            userID: element['group_owner']['player_ID'],
            displayname: element['group_owner']['player_displayname'],
            username: element['group_owner']['player_userlogin'],
            avatar: MediaURL(
              bigURL: element['group_owner']['player_avatar'],
              normalURL: element['group_owner']['player_avatar'],
              minURL: element['group_owner']['player_avatar'],
            ),
          ),
          logo: Media(
            mediaID: element['group_logo']['media_ID'],
            mediaURL: MediaURL(
              bigURL: element['group_logo']['media_bigURL'],
              normalURL: element['group_logo']['media_URL'],
              minURL: element['group_logo']['media_minURL'],
            ),
          ),
          banner: Media(
            mediaID: element['group_banner']['media_ID'],
            mediaURL: MediaURL(
              bigURL: element['group_banner']['media_bigURL'],
              normalURL: element['group_banner']['media_URL'],
              minURL: element['group_banner']['media_minURL'],
            ),
          ),
        ),
      );
    }

    armoyuresponse.response = APIGroupList(groups: list);

    return armoyuresponse;
  }

  Future<GroupDetailResponse> groupFetch({required int grupID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"grupID": grupID},
      endpoint: "0/0/${_EndpointConstants.groups}/0/0",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    GroupDetailResponse armoyuresponse = GroupDetailResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    armoyuresponse.response = APIGroupDetail(
      groupID: response['icerik']['group_ID'],
      groupName: response['icerik']['group_name'],
      groupShortname: response['icerik']['group_shortname'],
      groupJoinStatus:
          response['icerik']['group_joinstatus'] == 1 ? true : false,
      groupDescription: response['icerik']['group_description'],
      groupSocial: GroupSocial(
        discord: response['icerik']['group_social']['group_discord'],
        website: response['icerik']['group_social']['group_website'],
      ),
      groupURL: response['icerik']['group_URL'],
      groupOwner: UserInfo(
        userID: response['icerik']['group_owner']['player_ID'],
        displayname: response['icerik']['group_owner']['player_displayname'],
        username: response['icerik']['group_owner']['player_userlogin'],
        avatar: MediaURL(
          bigURL: response['icerik']['group_owner']['player_avatar'],
          normalURL: response['icerik']['group_owner']['player_avatar'],
          minURL: response['icerik']['group_owner']['player_avatar'],
        ),
      ),
      groupLogo: MediaURL(
        bigURL: response['icerik']['group_logo']['media_bigURL'],
        normalURL: response['icerik']['group_logo']['media_URL'],
        minURL: response['icerik']['group_logo']['media_minURL'],
      ),
      groupBanner: MediaURL(
        bigURL: response['icerik']['group_banner']['media_bigURL'],
        normalURL: response['icerik']['group_banner']['media_URL'],
        minURL: response['icerik']['group_banner']['media_minURL'],
      ),
    );

    return armoyuresponse;
  }

  Future<GroupUsersResponse> groupusersFetch({required int grupID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "grupID": grupID,
      },
      endpoint: "0/0/${_EndpointConstants.groupmembers}/0",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    GroupUsersResponse armoyuresponse = GroupUsersResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    List<UserInfo> users = [];

    for (var element in response['aciklama']) {
      users.add(
        UserInfo(
          userID: element['player_ID'],
          displayname: element['player_displayname'],
          username: element['player_userlogin'],
          avatar: MediaURL(
            bigURL: element['player_avatar']['media_bigURL'],
            normalURL: element['player_avatar']['media_URL'],
            minURL: element['player_avatar']['media_minURL'],
          ),
          role: element['player_role'],
        ),
      );
    }
    armoyuresponse.response = APIGroupUser(user: users);
    return armoyuresponse;
  }

  Future<GroupLeaveResponse> groupLeave({required int grupID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"grupID": grupID},
      endpoint: "0/0/${_EndpointConstants.groupleave}/0",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    GroupLeaveResponse armoyuresponse = GroupLeaveResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }
    return armoyuresponse;
  }

  Future<GroupSettingsResponse> groupsettingsSave({
    required int grupID,
    required String groupName,
    required String groupshortName,
    required String description,
    required String discordInvite,
    required String webLINK,
    required bool joinStatus,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "grupID": "$grupID",
        "baslik": groupName,
        "grupetiket": groupshortName,
        "aciklama": description,
        "discordlink": discordInvite,
        "website": webLINK,
        "alimdurum": joinStatus == true ? "1" : "0",
      },
      endpoint: "0/0/${_EndpointConstants.groupsettings}/0",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    GroupSettingsResponse armoyuresponse =
        GroupSettingsResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    return armoyuresponse;
  }

  Future<GroupChangeMediaResponse> changegroupmedia({
    required List<XFile> files,
    required int groupID,
    required String category,
  }) async {
    List<http.MultipartFile> photosCollection = [];
    for (var file in files) {
      photosCollection.add(await _apiHelpers.generateImageFile("media", file));
    }

    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "groupID": "$groupID",
        "category": category,
      },
      endpoint: "0/0/${_EndpointConstants.groupmedya}/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    GroupChangeMediaResponse armoyuresponse =
        GroupChangeMediaResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }
    armoyuresponse.response = APIGroupMedia(
      media: Media(
        mediaID: response['icerik']['media_ID'],
        mediaURL: MediaURL(
          bigURL: response['icerik']['media_URL']['media_bigURL'],
          normalURL: response['icerik']['media_URL']['media_URL'],
          minURL: response['icerik']['media_URL']['media_minURL'],
        ),
      ),
      category: response['icerik']['media_category'],
      date: response['icerik']['media_date'],
      type: response['icerik']['media_type'],
    );
    return armoyuresponse;
  }

  Future<GroupRequestAnswerResponse> grouprequestanswer({
    required int groupID,
    required String answer,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "grupID": "$groupID",
        "cevap": answer,
      },
      endpoint: "0/0/${_EndpointConstants.groupInviteanswer}/0/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    GroupRequestAnswerResponse armoyuresponse =
        GroupRequestAnswerResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    return armoyuresponse;
  }

  Future<GroupUserInviteResponse> groupuserInvite({
    required int groupID,
    required List<String> userList, //Username Type
  }) async {
    Map<String, String> formData = {"grupID": "$groupID"};
    for (int i = 0; i < userList.length; i++) {
      formData['users[$i]'] = userList[i];
    }

    Map<String, dynamic> response = await _apiHelpers.post(
      body: formData,
      endpoint: "0/0/${_EndpointConstants.groupInvite}/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    GroupUserInviteResponse armoyuresponse =
        GroupUserInviteResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    return armoyuresponse;
  }

  Future<GroupUserKickResponse> groupuserRemove({
    required int groupID,
    required int userID,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "grupID": groupID,
        "userID": userID,
      },
      endpoint: "0/0/${_EndpointConstants.groupuserremove}/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    GroupUserKickResponse armoyuresponse =
        GroupUserKickResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    return armoyuresponse;
  }

  Future<GroupCreateResponse> groupcreate({
    required String grupadi,
    required String kisaltmaadi,
    required int grupkategori,
    required int grupkategoridetay,
    required int varsayilanoyun,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "grupadi": grupadi,
        "kisaltmaadi": kisaltmaadi,
        "grupkategori": "$grupkategori",
        "grupkategoridetay": "$grupkategoridetay",
        "varsayilanoyun": "$varsayilanoyun"
      },
      endpoint: "0/0/${_EndpointConstants.groupcreate}/0/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    GroupCreateResponse armoyuresponse = GroupCreateResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    return armoyuresponse;
  }
}
