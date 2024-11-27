part of 'package:armoyu_services/armoyu_services.dart';

class JoinUsServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  JoinUsServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  Future<Map<String, dynamic>> fetchdepartment({
    required String username,
    required String password,
  }) async {
    password = _apiHelpers.generateMd5(password);

    return await _apiHelpers.post(
      endpoint: "$username/$password/${_EndpointConstants.permissions}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> applicationList({
    required String username,
    required String password,
    required int page,
  }) async {
    password = _apiHelpers.generateMd5(password);

    return await _apiHelpers.post(
      body: {
        "sayfa": page,
      },
      endpoint: "$username/$password/${_EndpointConstants.applicationList}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> requestjoindepartment({
    required String username,
    required String password,
    required int positionID,
    required String whyjoin,
    required String whyposition,
    required String howmachtime,
  }) async {
    password = _apiHelpers.generateMd5(password);

    return await _apiHelpers.post(
      body: {
        "positionID": "$positionID",
        "whyjoin": whyjoin,
        "whyposition": whyposition,
        "howmachtime": howmachtime,
      },
      endpoint:
          "$username/$password/${_EndpointConstants.requestjoindepertment}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }
}
