part of 'package:armoyu_services/armoyu_services.dart';

class LoginRegisterServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  LoginRegisterServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  Future<Map<String, dynamic>> inviteCodeTest({
    required String username,
    required String password,
    required String code,
  }) async {
    return await _apiHelpers.post(
      body: {
        "davetkodu": code,
      },
      endpoint:
          "$username/$password/${_EndpointConstants.invitecodefetch}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }
}
