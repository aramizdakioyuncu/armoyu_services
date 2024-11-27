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

  Future<Map<String, dynamic>> previuslogin(
      {required String username, required String password}) async {
    password = _apiHelpers.generateMd5(password);

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
