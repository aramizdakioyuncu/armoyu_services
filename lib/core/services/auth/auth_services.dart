part of 'package:armoyu_services/armoyu_services.dart';

final class AuthServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  AuthServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  // Future<Map<String, dynamic>> login({
  //   required LoginRequestModel loginRequestModel,
  // }) async {
  //   Map<String, dynamic> result = await _apiHelpers.post(
  //     endpoint: _EndpointConstants.authServicesLogin,
  //     headers: _apiHelpers.getRequestHeader(
  //       token: getToken(),
  //     ),
  //     body: loginRequestModel.toMap(),
  //   );

  //   if (result['durum'] == 1) {
  //     setToken(result['icerik']['access_token']);
  //   }

  //   return result;
  // }

  Future<Map<String, dynamic>> logout() async {
    final result = await _apiHelpers.post(
      endpoint: _EndpointConstants.users,
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
      body: {},
    );

    if (result['durum'] == 1) {
      setToken(null);
    }

    return result;
  }

  Future<Map<String, dynamic>> register({
    required RegisterRequestModel registerRequestModel,
    bool signIn = false,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      endpoint: _EndpointConstants.users,
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
      body: registerRequestModel.toMap(),
    );

    if (result['durum'] == 1) {
      _LoggingServices.instance.logConsole(
        message: result['icerik']['access_token'],
      );

      if (signIn) {
        setToken(result['icerik']['access_token']);
        _LoggingServices.instance.logConsole(message: "Giriş yapıldı!");
      }
    }

    return result;
  }

  ////////////////////////////////////////////////////////////////////////////PREVIUS////////////////////////////////////////////////////////////////////////////

  Future<LoginResponse> login(
      {required String username, required String password}) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> response = await _apiHelpers.post(
      endpoint:
          "$username/$password/${_EndpointConstants.previusAuthServicesLogin}/0/0/",
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    LoginResponse armoyuresponse = LoginResponse(result: result);
    if (armoyuresponse.result.status == false ||
        armoyuresponse.result.description == "Oyuncu bilgileri yanlış!") {
      return armoyuresponse;
    }

    List<Friend> friendlist = [];
    for (var friendInfo in response['icerik']['arkadasliste']) {
      friendlist.add(
        Friend(
          oyuncuID: friendInfo['oyuncuID'],
          oyuncuMinnakAvatar: MediaURL(
            bigURL: friendInfo['oyuncuminnakavatar'],
            normalURL: friendInfo['oyuncuminnakavatar'],
            minURL: friendInfo['oyuncuminnakavatar'],
          ),
          oyuncuKullaniciAdi: friendInfo['oyuncukullaniciadi'],
        ),
      );
    }

    List<Friend> commonfriendlist = [];
    for (var friendInfo in response['icerik']['ortakarkadasliste']) {
      commonfriendlist.add(
        Friend(
          oyuncuID: friendInfo['oyuncuID'],
          oyuncuMinnakAvatar: MediaURL(
            bigURL: friendInfo['oyuncuminnakavatar'],
            normalURL: friendInfo['oyuncuminnakavatar'],
            minURL: friendInfo['oyuncuminnakavatar'],
          ),
          oyuncuKullaniciAdi: friendInfo['oyuncukullaniciadi'],
        ),
      );
    }

    List<PopularGame> popularGames = [];
    for (var gameInfo in response['icerik']['popularGames']) {
      popularGames.add(
        PopularGame(
          gameID: gameInfo['game_ID'],
          gameName: gameInfo['game_name'],
          gameShortName: gameInfo['game_shortName'],
          gameURL: gameInfo['game_URL'],
          gameScore: gameInfo['game_score'],
          gameMoney: gameInfo['game_money'],
          gameLogo: Media(
            mediaID: gameInfo['game_logo']['media_ID'],
            mediaURL: MediaURL(
              bigURL: gameInfo['game_logo']['media_bigURL'],
              normalURL: gameInfo['game_logo']['media_URL'],
              minURL: gameInfo['game_logo']['media_minURL'],
            ),
          ),
          gameRole: GameRole(
            roleID: gameInfo['game_role']['role_ID'],
            roleName: gameInfo['game_role']['role_name'],
          ),
          gameClan: gameInfo['game_clan'],
        ),
      );
    }
    armoyuresponse.response = APILogin(
      arkadasdurum: response['icerik']['arkadasdurum'],
      cinsiyet: response['icerik']['cinsiyet'],
      arkadasdurumaciklama: response['icerik']['arkadasdurumaciklama'],
      playerID: response['icerik']['playerID'],
      username: response['icerik']['username'],
      firstName: response['icerik']['firstName'],
      lastName: response['icerik']['lastName'],
      displayName: response['icerik']['displayName'],
      displayNameV2: response['icerik']['displayNameV2'],
      displayNameV3: response['icerik']['displayNameV3'],
      url: response['icerik']['URL'],
      kulno: response['icerik']['kulno'],
      burc: response['icerik']['burc'],
      odp: response['icerik']['ODP'],
      level: response['icerik']['level'],
      levelXP: response['icerik']['levelXP'],
      levelColor: response['icerik']['levelColor'],
      avatar: response['icerik']['avatar'] == null
          ? null
          : Media(
              mediaID: response['icerik']['avatar']['media_ID'],
              mediaURL: MediaURL(
                bigURL: response['icerik']['avatar']['media_bigURL'],
                normalURL: response['icerik']['avatar']['media_URL'],
                minURL: response['icerik']['avatar']['media_minURL'],
              ),
            ),
      banner: response['icerik']['banner'] == null
          ? null
          : Media(
              mediaID: response['icerik']['banner']['media_ID'],
              mediaURL: MediaURL(
                bigURL: response['icerik']['banner']['media_bigURL'],
                normalURL: response['icerik']['banner']['media_URL'],
                minURL: response['icerik']['banner']['media_minURL'],
              ),
            ),
      detailInfo: response['icerik']['detailInfo'] == null
          ? null
          : APILoginDetailInfo(
              about: response['icerik']['detailInfo']['about'],
              age: response['icerik']['detailInfo']['age'],
              email: response['icerik']['detailInfo']['email'],
              friends: response['icerik']['detailInfo']['friends'],
              posts: response['icerik']['detailInfo']['posts'],
              awards: response['icerik']['detailInfo']['awards'],
              phoneNumber: response['icerik']['detailInfo']['phoneNumber'],
              birthdayDate: response['icerik']['detailInfo']['birthdayDate'],
              inviteCode: response['icerik']['detailInfo']['inviteCode'],
              lastloginDate: response['icerik']['detailInfo']['lastloginDate'],
              lastloginDateV2: response['icerik']['detailInfo']
                  ['lastloginDateV2'],
              lastfailedDate: response['icerik']['detailInfo']
                  ['lastfailedDate'],
              country: APICountry(
                countryID: response['icerik']['detailInfo']['country']
                    ['country_ID'],
                name: response['icerik']['detailInfo']['country']
                    ['country_name'],
                code: response['icerik']['detailInfo']['country']
                    ['country_code'],
                phonecode: response['icerik']['detailInfo']['country']
                    ['country_phoneCode'],
              ),
              province: APIProvince(
                provinceID: response['icerik']['detailInfo']['province']
                    ['province_ID'],
                name: response['icerik']['detailInfo']['province']
                    ['province_name'],
                platecode: response['icerik']['detailInfo']['province']
                    ['province_plateCode'],
                phonecode: response['icerik']['detailInfo']['province']
                    ['province_phoneCode'],
              ),
            ),
      userRole: response['icerik']['userRole'] == null
          ? null
          : UserRole(
              roleID: response['icerik']['userRole']['roleID'],
              roleName: response['icerik']['userRole']['roleName'],
              roleCategory: response['icerik']['userRole']['rolecategory'],
              roleColor: response['icerik']['userRole']['roleColor'],
            ),
      socailAccounts: response['icerik']['socailAccounts'] == null
          ? null
          : SocialAccounts(
              facebook: response['icerik']['socailAccounts']['facebook'],
              youtube: response['icerik']['socailAccounts']['youtube'],
              twitch: response['icerik']['socailAccounts']['twitch'],
              instagram: response['icerik']['socailAccounts']['instagram'],
              steam: response['icerik']['socailAccounts']['steam'],
              linkedin: response['icerik']['socailAccounts']['linkedin'],
              reddit: response['icerik']['socailAccounts']['reddit'],
              github: response['icerik']['socailAccounts']['github'],
            ),
      job: response['icerik']['job'] == null
          ? null
          : Job(
              jobID: response['icerik']['job']['job_ID'],
              jobName: response['icerik']['job']['job_name'],
              jobShortName: response['icerik']['job']['job_shortName'],
            ),
      defaultGroup: response['icerik']['defaultGroup'] == null
          ? null
          : DefaultGroup(
              groupID: response['icerik']['defaultGroup']['group_ID'],
              groupName: response['icerik']['defaultGroup']['group_name'],
              groupShortName: response['icerik']['defaultGroup']
                  ['group_shortName'],
              groupURL: response['icerik']['defaultGroup']['group_URL'],
              groupLogo: Media(
                mediaID: response['icerik']['defaultGroup']['group_logo']
                    ['media_ID'],
                mediaURL: MediaURL(
                  bigURL: response['icerik']['defaultGroup']['group_logo']
                      ['media_bigURL'],
                  normalURL: response['icerik']['defaultGroup']['group_logo']
                      ['media_URL'],
                  minURL: response['icerik']['defaultGroup']['group_logo']
                      ['media_minURL'],
                ),
              ),
              groupBanner: Media(
                mediaID: response['icerik']['defaultGroup']['group_banner']
                    ['media_ID'],
                mediaURL: MediaURL(
                  bigURL: response['icerik']['defaultGroup']['group_banner']
                      ['media_bigURL'],
                  normalURL: response['icerik']['defaultGroup']['group_banner']
                      ['media_URL'],
                  minURL: response['icerik']['defaultGroup']['group_banner']
                      ['media_minURL'],
                ),
              ),
              groupWallpaper: Media(
                mediaID: response['icerik']['defaultGroup']['group_wallpaper']
                    ['media_ID'],
                mediaURL: MediaURL(
                  bigURL: response['icerik']['defaultGroup']['group_wallpaper']
                      ['media_bigURL'],
                  normalURL: response['icerik']['defaultGroup']
                      ['group_wallpaper']['media_URL'],
                  minURL: response['icerik']['defaultGroup']['group_wallpaper']
                      ['media_minURL'],
                ),
              ),
            ),
      roleID: response['icerik']['roleID'],
      roleName: response['icerik']['roleName'],
      roleColor: response['icerik']['roleColor'],
      koyuncuhak: response['icerik']['koyuncuhak'],
      ortakarkadaslar: response['icerik']['ortakarkadaslar'],
      ortakarkadasliste: commonfriendlist,
      arkadasliste: friendlist,
      banHistory: response['icerik']['banHistory'] == null
          ? null
          : APILoginBanHistory(
              banStatus: response['icerik']['banHistory']['ban_status'],
              banCount: response['icerik']['banHistory']['ban_count'],
              banReason: response['icerik']['banHistory']['ban_reason'],
              banRemaining: response['icerik']['banHistory']['ban_remaining'],
            ),
      registeredDate: response['icerik']['registeredDate'],
      registeredDateV2: response['icerik']['registeredDateV2'],
      favTeam: response['icerik']['favTeam'] == null
          ? null
          : FavoriteTeam(
              teamID: response['icerik']['favTeam']['team_ID'],
              teamName: response['icerik']['favTeam']['team_name'],
              teamLogo: MediaURL(
                bigURL: response['icerik']['favTeam']['team_logo'],
                normalURL: response['icerik']['favTeam']['team_logo'],
                minURL: response['icerik']['favTeam']['team_logo'],
              ),
            ),
      mevcutoyunsayisi: response['icerik']['mevcutoyunsayisi'],
      popularGames: popularGames,
    );

    return armoyuresponse;
  }

  Future<Map<String, dynamic>> previusregister({
    required String username,
    required String password,
    required String name,
    required String lastname,
    required String email,
    required String rpassword,
    required String inviteCode,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> result = await _apiHelpers.post(
      body: {
        "islem": "kayit-ol",
        "kullaniciadi": username,
        "ad": name,
        "soyad": lastname,
        "email": email,
        "parola": password,
        "parolakontrol": rpassword,
        "davetkodu": inviteCode,
      },
      endpoint: "$username/$password/${_EndpointConstants.register}/0/0/",
    );
    return result;
  }

  Future<Map<String, dynamic>> previuslogOut({
    required String username,
    required String password,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> result = await _apiHelpers.post(
      body: {
        "islem": "cikis-yap",
      },
      endpoint: "$username/$password/${_EndpointConstants.logout}/0/0/",
    );
    return result;
  }
}
