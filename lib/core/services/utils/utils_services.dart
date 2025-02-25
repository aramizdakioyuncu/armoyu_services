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
            groupDiscord: element['group_social']['group_discord'],
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
            owner: element['group_myRole']['owner'],
            userInvite: element['group_myRole']['user_invite'],
            userKick: element['group_myRole']['user_kick'],
            userRole: element['group_myRole']['user_role'],
            groupSettings: element['group_myRole']['group_settings'],
            groupFiles: element['group_myRole']['group_files'],
            groupEvents: element['group_myRole']['group_events'],
            groupRole: element['group_myRole']['group_role'],
            groupSurvey: element['group_myRole']['group_survey'],
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

  //

  Future<ForeignCurrencyListResponse> foreigncurrencylist(
      {required int page}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"sayfa": "$page"},
      endpoint: "0/0/piyasa-kur/0/0",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    ForeignCurrencyListResponse armoyuresponse =
        ForeignCurrencyListResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    List<ForeignCurrencyList> currencyList = [];
    for (var element in response['icerik']) {
      currencyList.add(
        ForeignCurrencyList(
          name: element['dovizkisaisim'],
          value: element['dovizdeger'],
          image: element['dovizlink'],
        ),
      );
    }
    armoyuresponse.response = currencyList;
    return armoyuresponse;
  }

  Future<WeatherListResponse> weatherlist({required int page}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"sayfa": "$page"},
      endpoint: "0/0/hava-durumu/0/0",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    WeatherListResponse armoyuresponse = WeatherListResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    List<WeatherAPI> list = [];
    for (var element in response['icerik']) {
      list.add(
        WeatherAPI(
          city: element['sehir'],
          value: element['derece'],
          weatherlogo: element['logo'],
        ),
      );
    }
    armoyuresponse.response = list;
    return armoyuresponse;
  }

  Future<SuperLigResponse> superlig({required int page}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"sayfa": "$page"},
      endpoint: "0/0/super-lig/0/0",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    SuperLigResponse armoyuresponse = SuperLigResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    List<SuperLigAPI> list = [];
    for (var element in response['icerik']) {
      list.add(
        SuperLigAPI(
          teamname: element['takimadi'],
          avarage: int.parse(element['avaraj']),
          playedmatchcount: int.parse(element['oynananmac']),
          point: int.parse(element['puan']),
          teamlogo: element['logo'] == null
              ? null
              : MediaURL(
                  bigURL: element['logo'],
                  normalURL: element['logo'],
                  minURL: element['logo'],
                ),
        ),
      );
    }
    armoyuresponse.response = list;
    return armoyuresponse;
  }

  Future<GamesOnSaleResponse> gamesOnSale({required int page}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"sayfa": "$page"},
      endpoint: "0/0/indirimdeki-oyunlar/0/0",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    GamesOnSaleResponse armoyuresponse = GamesOnSaleResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    List<GamesOnSaleAPI> list = [];
    for (var element in response['icerik']) {
      list.add(
        GamesOnSaleAPI(
          gameName: element['oyunadi'],
          gameLogo: element['logo'],
          gameLink: element['oyunlink'],
          gamePrice: element['listestil'],
          gamePriceStyle: element['indirimfiyat'],
          gameDiscount: element['indirimoran'],
        ),
      );
    }
    armoyuresponse.response = list;
    return armoyuresponse;
  }

  Future<NewRegisteredUsersResponse> newRegisterUsers(
      {required int page}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"sayfa": "$page"},
      endpoint: "0/0/yeni-uyeler/0/0",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    NewRegisteredUsersResponse armoyuresponse =
        NewRegisteredUsersResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    List<NewRegisteredUsersAPI> list = [];
    for (var element in response['icerik']) {
      list.add(
        NewRegisteredUsersAPI(
          displayname: element['oyuncuadi'],
          avatar: MediaURL(
            bigURL: element['oyuncuavatar'],
            normalURL: element['oyuncuavatar'],
            minURL: element['oyuncuavatar'],
          ),
          level: int.parse(element['oyuncuseviye']),
          levelcolor: element['oyuncuseviyerenk'],
          xp: element['oyuncuxp'],
          url: element['oyunculink'],
          isme: element['isme'] == 1 ? true : false,
        ),
      );
    }
    armoyuresponse.response = list;
    return armoyuresponse;
  }

  Future<MinecraftStatisticsResponse> minecraftStatistics(
      {required int page}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"sayfa": "$page"},
      endpoint: "0/0/minecraft-istatistik/0/0",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    MinecraftStatisticsResponse armoyuresponse =
        MinecraftStatisticsResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    List<MinecraftStatisticsAPI> list = [];
    for (var element in response['icerik']) {
      list.add(
        MinecraftStatisticsAPI(
          playername: element['kullaniciad'],
          clanname: element['klan'],
          clancolor: element['klanrenk'],
          point: element['lessayisi'],
        ),
      );
    }
    armoyuresponse.response = list;
    return armoyuresponse;
  }
}
