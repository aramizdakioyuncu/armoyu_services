import 'package:armoyu_services/export.dart';

final class AuthServices {
  final String? token;
  final String? appVersion;
  final ApiHelpers apiHelpers;

  AuthServices({
    required this.token,
    required this.appVersion,
    required this.apiHelpers,
  });

  Future<Map<String, dynamic>> login({
    required LoginRequestModel loginRequestModel,
  }) async {
    Map<String, dynamic> result = await apiHelpers.post(
      endpoint: EndpointConstants.authServicesLogin,
      headers: apiHelpers.getRequestHeader(
        token: token,
        appVersion: appVersion,
      ),
      body: loginRequestModel.toMap(),
    );

    return result;
  }

  Future<Map<String, dynamic>> logout() async {
    return await apiHelpers.post(
      endpoint: EndpointConstants.users,
      headers: apiHelpers.getRequestHeader(
        token: token,
        appVersion: appVersion,
      ),
      body: {},
    );
  }

  Future<Map<String, dynamic>> register({
    required RegisterRequestModel registerRequestModel,
  }) async {
    Map<String, dynamic> result = await apiHelpers.post(
      endpoint: EndpointConstants.users,
      headers: apiHelpers.getRequestHeader(
        token: token,
        appVersion: appVersion,
      ),
      body: registerRequestModel.toMap(),
    );

    return result;
  }
}
