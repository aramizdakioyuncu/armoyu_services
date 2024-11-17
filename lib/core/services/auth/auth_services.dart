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

  Future<Map<String, dynamic>> login({
    required LoginRequestModel loginRequestModel,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      endpoint: _EndpointConstants.authServicesLogin,
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
      body: loginRequestModel.toMap(),
    );

    if (result['durum'] == 1) {
      setToken(result['icerik']['access_token']);
    }

    return result;
  }

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
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future<Map<String, dynamic>> getappdetail(
      {required String username, required String password}) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      endpoint:
          "$username/$password/${_EndpointConstants.previusAuthServicesLogin}/0/0/",
    );
    return result;
  }

  Future<Map<String, dynamic>> fetchUserInfo({
    required String username,
    required String password,
    required int userID,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      body: {"oyuncubakid": "$userID"},
      endpoint:
          "$username/$password/${_EndpointConstants.previusAuthServicesLogin}/0/0/",
    );
    return result;
  }

  Future<Map<String, dynamic>> previuslogin(
      {required String username, required String password}) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      endpoint:
          "$username/$password/${_EndpointConstants.previusAuthServicesLogin}/0/0/",
    );

    return result;
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
    Map<String, dynamic> result = await _apiHelpers.post(
      body: {
        "islem": "cikis-yap",
      },
      endpoint: "$username/$password/${_EndpointConstants.logout}/0/0/",
    );
    return result;
  }

  Future<Map<String, dynamic>> forgotpassword({
    required String username,
    required String password,
    required String useremail,
    required String userresettype,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      body: {
        "kullaniciadi": username,
        "email": useremail,
        "sifirlamatercihi": userresettype
      },
      endpoint: "$username/$password/${_EndpointConstants.forgotPassword}/0/0/",
    );
    return result;
  }

  Future<Map<String, dynamic>> forgotpassworddone({
    required String username,
    required String password,
    required String useremail,
    required String userresettype,
    required String securitycode,
    required String repassword,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      body: {
        "kullaniciadi": username,
        "email": useremail,
        "dogrulamakodu": securitycode,
        "sifre": password,
        "sifretekrar": repassword
      },
      endpoint: "$username/$password/${_EndpointConstants.forgotPassword}/0/0/",
    );
    return result;
  }

  Future<Map<String, dynamic>> lookProfile({
    required String username,
    required String password,
    required String userID,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      body: {
        "oyuncubakid": userID,
      },
      endpoint:
          "$username/$password/${_EndpointConstants.previusAuthServicesLogin}/0/0/",
    );
    return result;
  }

  Future<Map<String, dynamic>> lookProfilewithusername({
    required String username,
    required String password,
    required String userusername,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      body: {
        "oyuncubakusername": userusername,
      },
      endpoint:
          "$username/$password/${_EndpointConstants.previusAuthServicesLogin}/0/0/",
    );
    return result;
  }

  Future<Map<String, dynamic>> myGroups({
    required String username,
    required String password,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      body: {},
      endpoint: "$username/$password/${_EndpointConstants.mygroups}/0/0/",
    );
    return result;
  }

  Future<Map<String, dynamic>> mySchools({
    required String username,
    required String password,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      body: {},
      endpoint: "$username/$password/${_EndpointConstants.myschools}/0/0/",
    );
    return result;
  }

  Future<Map<String, dynamic>> myStations({
    required String username,
    required String password,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      body: {},
      endpoint: "$username/$password/${_EndpointConstants.mystations}/0/0/",
    );
    return result;
  }

  Future<Map<String, dynamic>> getprofilePosts({
    required String username,
    required String password,
    required String userID,
    required String category,
    required String page,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      body: {
        "oyuncubakid": userID,
        "limit": "20",
        "paylasimozellik": category,
      },
      endpoint: "$username/$password/${_EndpointConstants.profileposts}/$page/",
    );
    return result;
  }

  Future<Map<String, dynamic>> getplayerxp({
    required String username,
    required String password,
    required int page,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      body: {"sayfa": page},
      endpoint: "$username/$password/${_EndpointConstants.xpordering}/0/0",
    );
    return result;
  }

  Future<Map<String, dynamic>> getplayerpop({
    required String username,
    required String password,
    required int page,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      body: {"sayfa": page},
      endpoint: "$username/$password/${_EndpointConstants.popordering}/0/0",
    );
    return result;
  }

  Future<Map<String, dynamic>> getnotifications({
    required String username,
    required String password,
    required String kategori,
    required String kategoridetay,
    required int page,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      body: {
        "kategori": kategori,
        "kategoridetay": kategoridetay,
        "sayfa": page,
        "limit": "20",
      },
      endpoint: "$username/$password/${_EndpointConstants.notifications}/0/0",
    );
    return result;
  }

  Future<Map<String, dynamic>> getchats({
    required String username,
    required String password,
    required int page,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      body: {
        "sayfa": page,
        "limit": "30",
      },
      endpoint: "$username/$password/${_EndpointConstants.chat}/0/0",
    );
    return result;
  }

  Future<Map<String, dynamic>> getnewchatfriendlist({
    required String username,
    required String password,
    required int page,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      body: {
        "sayfa": page,
        "limit": "30",
      },
      endpoint: "$username/$password/${_EndpointConstants.chatfriends}/0",
    );
    return result;
  }

  Future<Map<String, dynamic>> getdeailchats({
    required String username,
    required String password,
    required int chatID,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      body: {
        "sohbetID": chatID,
        "sohbetturu": "ozel",
      },
      endpoint: "$username/$password/${_EndpointConstants.chatdetail}/0/0",
    );
    return result;
  }

  Future<Map<String, dynamic>> sendchatmessage({
    required String username,
    required String password,
    required int userID,
    required String message,
    required String type,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      body: {
        "oyuncubakid": "$userID",
        "icerik": message,
        "turu": type,
      },
      endpoint: "$username/$password/${_EndpointConstants.chatsend}/0/0",
    );
    return result;
  }
}
