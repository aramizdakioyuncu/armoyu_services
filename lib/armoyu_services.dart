import 'package:armoyu_services/export.dart';
export 'package:armoyu_services/export.dart';

class ARMOYUServices {
  late final LoggingServices _loggingServices;
  late final AuthServices _authServices;
  late final UserServices _userServices;
  late final UtilsServices _utilsServices;

  final String apiKey;

  String? _token;
  set token(value) => _token = value;

  ARMOYUServices({required this.apiKey}) {
    _loggingServices = LoggingServices();

    _authServices = AuthServices(
      token: _token,
      appVersion: _loggingServices.version,
    );

    _userServices = UserServices(
      token: _token,
      appVersion: _loggingServices.version,
    );

    _utilsServices = UtilsServices(
      token: _token,
      appVersion: _loggingServices.version,
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
  }) async {
    Map<String, dynamic> result = await _authServices.register(
      registerRequestModel: registerRequestModel,
    );

    if (result['durum'] == 1) {
      _loggingServices.logConsole(
        message: result['icerik']['access_token'],
      );
    }

    return result;
  }
}
