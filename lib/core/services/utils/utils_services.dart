part of 'package:armoyu_services/armoyu_services.dart';

class UtilsServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  UtilsServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  Future<ServiceResult> getappdetail() async {
    Map<String, dynamic> response = await _apiHelpers.post(
      endpoint: "0/0/${_EndpointConstants.previusAuthServicesLogin}/0/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    if (response['durum'] == 0) {
      return result;
    }
    return result;
  }

  Future<ServiceResult> fetchUserInfo({required int userID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"oyuncubakid": "$userID"},
      endpoint: "0/0/${_EndpointConstants.previusAuthServicesLogin}/0/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    if (response['durum'] == 0) {
      return result;
    }
    return result;
  }

  Future<ServiceResult> forgotpassword({
    required String username,
    required String useremail,
    required String userresettype,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "kullaniciadi": username,
        "email": useremail,
        "sifirlamatercihi": userresettype
      },
      endpoint: "0/0${_EndpointConstants.forgotPassword}/0/0/",
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    if (response['durum'] == 0) {
      return result;
    }
    return result;
  }

  Future<ServiceResult> forgotpassworddone({
    required String username,
    required String password,
    required String useremail,
    required String securitycode,
    required String repassword,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "kullaniciadi": username,
        "email": useremail,
        "dogrulamakodu": securitycode,
        "sifre": password,
        "sifretekrar": repassword
      },
      endpoint: "0/0/${_EndpointConstants.forgotPassword}/0/0/",
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    if (response['durum'] == 0) {
      return result;
    }
    return result;
  }

  Future<LookProfileResponse> lookProfile({required int userID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"oyuncubakid": userID},
      endpoint: "0/0/${_EndpointConstants.previusAuthServicesLogin}/0/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    LookProfileResponse armoyuresponse = LookProfileResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    armoyuresponse.response = APILogin.updateclass(response);
    return armoyuresponse;
  }

  Future<LookProfilewithUsernameResponse> lookProfilewithusername(
      {required String userusername}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"oyuncubakusername": userusername},
      endpoint: "0/0/${_EndpointConstants.previusAuthServicesLogin}/0/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    LookProfilewithUsernameResponse armoyuresponse =
        LookProfilewithUsernameResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    armoyuresponse.response = APILogin.updateclass(response);
    return armoyuresponse;
  }

  Future<APIMyGroupListResponse> myGroups() async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {},
      endpoint: "0/0/${_EndpointConstants.mygroups}/0/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    APIMyGroupListResponse armoyuresponse =
        APIMyGroupListResponse(result: result);
    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    List<APIMyGroupList> groupList = [];
    for (var element in response['icerik']) {
      groupList.add(
        APIMyGroupList(
          groupID: element['group_ID'],
          groupName: element['group_name'],
          groupShortName: element['group_shortname'],
          groupJoinStatus: element['group_joinstatus'],
          groupDescription: element['group_description'],
          groupSocial: MyGroupSocial(
            groupWebsite: element['group_social']['group_website'],
            groupDiscord: element['group_ID']['group_discord'],
          ),
          groupURL: element['group_URL'],
          groupUserCount: element['group_usercount'],
          groupLogo: Media(
            mediaID: element['group_logo']['media_ID'],
            mediaURL: MediaURL(
              bigURL: element['group_logo']['media_bigURL'],
              normalURL: element['group_logo']['media_URL'],
              minURL: element['group_logo']['media_minURL'],
            ),
          ),
          groupBanner: Media(
            mediaID: element['group_banner']['media_ID'],
            mediaURL: MediaURL(
              bigURL: element['group_banner']['media_bigURL'],
              normalURL: element['group_banner']['media_URL'],
              minURL: element['group_banner']['media_minURL'],
            ),
          ),
          groupMyRole: MyGroupMyRole(
            owner: element['owner'],
            userInvite: element['user_invite'],
            userKick: element['user_kick'],
            userRole: element['user_role'],
            groupSettings: element['group_settings'],
            groupFiles: element['group_files'],
            groupEvents: element['group_events'],
            groupRole: element['group_role'],
            groupSurvey: element['group_survey'],
          ),
        ),
      );
    }

    armoyuresponse.response = groupList;
    return armoyuresponse;
  }

  Future<APIMySchoolListResponse> mySchools() async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {},
      endpoint: "0/0/${_EndpointConstants.myschools}/0/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    APIMySchoolListResponse armoyuresponse =
        APIMySchoolListResponse(result: result);
    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    List<APIMySchoolList> myschoolList = [];

    for (var element in response['icerik']) {
      myschoolList.add(
        APIMySchoolList(
          schoolID: element['school_ID'],
          schoolName: element['school_name'],
          schoolURL: element['school_URL'],
          schoolUserCount: element['school_usercount'],
          schoolLogo: Media(
            mediaID: element['school_logo']['media_ID'],
            mediaURL: MediaURL(
              bigURL: element['school_logo']['media_bigURL'],
              normalURL: element['school_logo']['media_URL'],
              minURL: element['school_logo']['media_minURL'],
            ),
          ),
          schoolBanner: Media(
            mediaID: element['school_banner']['media_ID'],
            mediaURL: MediaURL(
              bigURL: element['school_banner']['media_bigURL'],
              normalURL: element['school_banner']['media_URL'],
              minURL: element['school_banner']['media_minURL'],
            ),
          ),
        ),
      );
    }

    armoyuresponse.response = myschoolList;

    return armoyuresponse;
  }

  Future<ServiceResult> myStations() async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {},
      endpoint: "0/0/${_EndpointConstants.mystations}/0/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    if (response['durum'] == 0) {
      return result;
    }
    return result;
  }

  Future<ServiceResult> getprofilePosts({
    required String userID,
    required String category,
    required int page,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "oyuncubakid": userID,
        "limit": "20",
        "paylasimozellik": category,
      },
      endpoint: "0/0/${_EndpointConstants.profileposts}/$page/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    if (response['durum'] == 0) {
      return result;
    }
    return result;
  }

  Future<PlayerPopResponse> getplayerxp({required int page}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"sayfa": page},
      endpoint: "0/0/${_EndpointConstants.xpordering}/0/0",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    PlayerPopResponse armoyuresponse = PlayerPopResponse(result: result);
    if (response['durum'] == 0) {
      return armoyuresponse;
    }
    List<APIPlayerPop> xplist = [];
    for (var element in response['icerik']) {
      xplist.add(
        APIPlayerPop(
          oyuncuID: element['oyuncuID'],
          oyuncuAdSoyad: element['oyuncuadsoyad'],
          oyuncuKullaniciAdi: element['oyuncukullaniciadi'],
          oyuncuAvatar: element['oyuncuavatar'],
          oyuncuSeviye: element['oyuncuseviye'],
          oyuncuSeviyeXP: element['oyuncuseviyexp'],
          oyuncuSeviyeSezonlukXP: element['oyuncuseviyesezonlukxp'],
          oyuncuPop: element['oyuncupop'],
        ),
      );
    }
    armoyuresponse.response = xplist;

    return armoyuresponse;
  }

  Future<PlayerPopResponse> getplayerpop({required int page}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"sayfa": page},
      endpoint: "0/0/${_EndpointConstants.popordering}/0/0",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    PlayerPopResponse armoyuresponse = PlayerPopResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }
    List<APIPlayerPop> poplist = [];
    for (var element in response['icerik']) {
      poplist.add(
        APIPlayerPop(
          oyuncuID: element['oyuncuID'],
          oyuncuAdSoyad: element['oyuncuadsoyad'],
          oyuncuKullaniciAdi: element['oyuncukullaniciadi'],
          oyuncuAvatar: element['oyuncuavatar'],
          oyuncuSeviye: element['oyuncuseviye'],
          oyuncuSeviyeXP: element['oyuncuseviyexp'],
          oyuncuSeviyeSezonlukXP: element['oyuncuseviyesezonlukxp'],
          oyuncuPop: element['oyuncupop'],
        ),
      );
    }

    armoyuresponse.response = poplist;

    return armoyuresponse;
  }

  Future<ChatListResponse> getchats({required int page}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "sayfa": page,
        "limit": "30",
      },
      endpoint: "0/0/${_EndpointConstants.chat}/0/0",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    ChatListResponse armoyuresponse = ChatListResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    List<APIChatList> chatList = [];
    for (var element in response['icerik']) {
      chatList.add(
        APIChatList(
          kullID: element['kullid'],
          adSoyad: element['adisoyadi'],
          kullAdi: element['kulladi'],
          bildirim: element['bildirim'],
          sonGiris: element['songiris'],
          sonMesaj: element['sonmesaj'],
          sohbetTuru: element['sohbetturu'],
          chatImage: Media(
            mediaID: element['chatImage']['media_ID'],
            mediaURL: MediaURL(
              bigURL: element['chatImage']['media_bigURL'],
              normalURL: element['chatImage']['media_URL'],
              minURL: element['chatImage']['media_minURL'],
            ),
          ),
          foto: element['foto'],
        ),
      );
    }

    armoyuresponse.response = chatList;
    return armoyuresponse;
  }

  Future<ServiceResult> getnewchatfriendlist({required int page}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "sayfa": page,
        "limit": "30",
      },
      endpoint: "0/0/${_EndpointConstants.chatfriends}/0",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    if (response['durum'] == 0) {
      return result;
    }
    return result;
  }

  Future<ChatFetchDetailResponse> getdetailchats({required int chatID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "sohbetID": chatID,
        "sohbetturu": "ozel",
      },
      endpoint: "0/0/${_EndpointConstants.chatdetail}/0/0",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    ChatFetchDetailResponse armoyuresponse =
        ChatFetchDetailResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    List<APIChatDetailList> chatdetailList = [];
    for (var element in response['icerik']) {
      chatdetailList.add(
        APIChatDetailList(
          sohbetKim: element['sohbetkim'],
          renkKodu: element['renkkodu'],
          adSoyad: element['adsoyad'],
          avatar: element['avatar'],
          mesajIcerik: element['mesajicerik'],
          zaman: element['zaman'],
          zamanTarih: element['zamantarih'],
          zamanSaat: element['zamansaat'],
          durum: element['durum'],
        ),
      );
    }

    armoyuresponse.response = chatdetailList;
    return armoyuresponse;
  }

  Future<ServiceResult> sendchatmessage({
    required int userID,
    required String message,
    required String type,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "oyuncubakid": "$userID",
        "icerik": message,
        "turu": type,
      },
      endpoint: "0/0/${_EndpointConstants.chatsend}/0/0",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    if (response['durum'] == 0) {
      return result;
    }
    return result;
  }
}
