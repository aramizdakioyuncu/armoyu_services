library armoyu_services.dart;

import 'package:armoyu_services/export.dart';
export 'package:armoyu_services/export.dart';
import 'package:http/http.dart' as http;

part 'core/services/logging/logging_services.dart';
part 'core/services/auth/auth_services.dart';
part 'core/services/user/user_services.dart';
part 'core/services/utils/utils_services.dart';
part 'core/helpers/api_helpers.dart';
part 'core/constants/endpoint_constants.dart';

class ARMOYUServices {
  late final _AuthServices _authServices;
  late final _UserServices _userServices;
  late final _UtilsServices _utilsServices;
  late final _ApiHelpers _apiHelpers;

  final String apiKey;

  String? _token;
  String? get _getToken => _token;
  set token(value) => _token = value;

  ARMOYUServices({required this.apiKey}) {
    _apiHelpers = _ApiHelpers(apiKey: apiKey);

    _authServices = _AuthServices(
      getToken: () => _getToken,
      apiHelpers: _apiHelpers,
    );

    _userServices = _UserServices(
      getToken: () => _getToken,
      apiHelpers: _apiHelpers,
    );

    _utilsServices = _UtilsServices(
      getToken: () => _getToken,
      apiHelpers: _apiHelpers,
    );
  }

  Future<void> setup() async {
    await _LoggingServices.instance.setup();
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
    Map<String, dynamic> result = await _authServices.logout();

    if (result['durum'] == 1) {
      _token = null;
    }

    return result;
  }

  Future<Map<String, dynamic>> register({
    required RegisterRequestModel registerRequestModel,
    bool signIn = false,
  }) async {
    Map<String, dynamic> result = await _authServices.register(
      registerRequestModel: registerRequestModel,
    );

    if (result['durum'] == 1) {
      _LoggingServices.instance.logConsole(
        message: result['icerik']['access_token'],
      );

      if (signIn) {
        token = result['icerik']['access_token'];
        _LoggingServices.instance.logConsole(message: "Giriş yapıldı!");
      }
    }

    return result;
  }
}
