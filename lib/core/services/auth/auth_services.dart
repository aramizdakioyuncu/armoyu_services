import 'package:armoyu_services/export.dart';

final class AuthServices {
  late final ApiHelpers _apiHelpers;

  final String? token;
  final String? appVersion;

  AuthServices({
    required this.token,
    required this.appVersion,
  }) {
    _apiHelpers = ApiHelpers();
  }

  Future<Map<String, dynamic>> login({
    required LoginRequestModel loginRequestModel,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      endpoint: EndpointConstants.authServicesLogin,
      headers: _apiHelpers.getRequestHeader(
        token: token,
        appVersion: appVersion,
      ),
      body: loginRequestModel.toMap(),
    );

    return result;
  }

  Future<Map<String, dynamic>> logout() async {
    return await _apiHelpers.post(
      endpoint: EndpointConstants.users,
      headers: _apiHelpers.getRequestHeader(
        token: token,
        appVersion: appVersion,
      ),
      body: {},
    );
  }

  Future<Map<String, dynamic>> register({
    required RegisterRequestModel registerRequestModel,
  }) async {
    Map<String, dynamic> result = await _apiHelpers.post(
      endpoint: EndpointConstants.users,
      headers: _apiHelpers.getRequestHeader(
        token: token,
        appVersion: appVersion,
      ),
      body: registerRequestModel.toMap(),
    );

    return result;
  }
}
