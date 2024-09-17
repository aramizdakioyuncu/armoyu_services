import 'package:armoyu_services/export.dart';
export 'package:armoyu_services/export.dart';

class ARMOYUServices {
  late final AuthServices _authServices;
  late final UserServices _userServices;
  late final UtilsServices _utilsServices;

  final String apiKey;
  late final ApiHelpers _apiHelpers;

  String? _token;
  set token(value) {
    _token = value;

    final version = LoggingServices.instance.version;
    _authServices.reload(t: _token, a: version);
    _userServices.reload(t: _token, a: version);
    _utilsServices.reload(t: _token, a: version);
  }

  ARMOYUServices({required this.apiKey}) {
    _apiHelpers = ApiHelpers(apiKey: apiKey);

    _authServices = AuthServices(
      token: _token,
      appVersion: LoggingServices.instance.version,
      apiHelpers: _apiHelpers,
    );

    _userServices = UserServices(
      token: _token,
      appVersion: LoggingServices.instance.version,
      apiHelpers: _apiHelpers,
    );

    _utilsServices = UtilsServices(
      token: _token,
      appVersion: LoggingServices.instance.version,
      apiHelpers: _apiHelpers,
    );
  }

  Future<Map<String, dynamic>> getFeedbackRequest() async {
    return await _utilsServices.getFeedbackRequest();
  }

  Future<Map<String, dynamic>> getUsers() async {
    return await _userServices.getUsers();
  }

  Future<Map<String, dynamic>> deleteUser({required int userId}) async {
    return await _userServices.deleteUser(userId: userId);
  }

  Future<Map<String, dynamic>> addFriend({
    required AddFriendRequestModel addFriendRequestModel,
  }) async {
    return await _userServices.addFriend(
      addFriendRequestModel: addFriendRequestModel,
    );
  }

  Future<Map<String, dynamic>> login(
      {required LoginRequestModel loginRequestModel}) async {
    Map<String, dynamic> result = await _authServices.login(
      loginRequestModel: loginRequestModel,
    );

    if (result['durum'] == 1) {
      token = result['icerik']['access_token'];
    }

    return result;
  }

  Future<Map<String, dynamic>> logout() async {
    return await _authServices.logout();
  }

  Future<Map<String, dynamic>> register({
    required RegisterRequestModel registerRequestModel,
    bool signIn = false,
  }) async {
    Map<String, dynamic> result = await _authServices.register(
      registerRequestModel: registerRequestModel,
    );

    if (result['durum'] == 1) {
      LoggingServices.instance.logConsole(
        message: result['icerik']['access_token'],
      );

      if (signIn) {
        token = result['icerik']['access_token'];
        LoggingServices.instance.logConsole(message: "Giriş yapıldı!");
      }
    }

    return result;
  }
}
