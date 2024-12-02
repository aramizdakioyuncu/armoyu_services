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

  // Future<Map<String, dynamic>> logout() async {
  //   final result = await _apiHelpers.post(
  //     endpoint: _EndpointConstants.users,
  //     headers: _apiHelpers.getRequestHeader(
  //       token: getToken(),
  //     ),
  //     body: {},
  //   );

  //   if (result['durum'] == 1) {
  //     setToken(null);
  //   }

  //   return result;
  // }

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

//TOKEN AYARLARMA
    setToken(response['icerik']['aciklama']);
//TOKEN AYARLARMA

    armoyuresponse.response = APILogin.updateclass(response);

    return armoyuresponse;
  }

  Future<Map<String, dynamic>> register({
    required String username,
    required String password,
    required String name,
    required String lastname,
    required String email,
    required String rpassword,
    String? inviteCode,
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
        "davetkodu": inviteCode ?? "",
      },
      endpoint: "$username/$password/${_EndpointConstants.register}/0/0/",
    );

//TOKEN AYARLARMA
    setToken(result['icerik']['aciklama']);
//TOKEN AYARLARMA

    return result;
  }

  Future<Map<String, dynamic>> logOut({
    required String username,
    required String password,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> result = await _apiHelpers.post(
      body: {
        "islem": "cikis-yap",
      },
      endpoint: "$username/$password/${_EndpointConstants.logout}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
    return result;
  }
}
