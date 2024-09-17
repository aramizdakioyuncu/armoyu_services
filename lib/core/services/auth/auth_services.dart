part of 'package:armoyu_services/armoyu_services.dart';

final class _AuthServices {
  String? Function() getToken;
  final _ApiHelpers apiHelpers;

  _AuthServices({
    required this.getToken,
    required this.apiHelpers,
  });

  Future<Map<String, dynamic>> login({
    required LoginRequestModel loginRequestModel,
  }) async {
    Map<String, dynamic> result = await apiHelpers.post(
      endpoint: _EndpointConstants.authServicesLogin,
      headers: apiHelpers.getRequestHeader(
        token: getToken(),
      ),
      body: loginRequestModel.toMap(),
    );

    return result;
  }

  Future<Map<String, dynamic>> logout() async {
    return await apiHelpers.post(
      endpoint: _EndpointConstants.users,
      headers: apiHelpers.getRequestHeader(
        token: getToken(),
      ),
      body: {},
    );
  }

  Future<Map<String, dynamic>> register({
    required RegisterRequestModel registerRequestModel,
  }) async {
    Map<String, dynamic> result = await apiHelpers.post(
      endpoint: _EndpointConstants.users,
      headers: apiHelpers.getRequestHeader(
        token: getToken(),
      ),
      body: registerRequestModel.toMap(),
    );

    return result;
  }
}
