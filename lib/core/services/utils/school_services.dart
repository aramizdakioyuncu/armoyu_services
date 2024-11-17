part of 'package:armoyu_services/armoyu_services.dart';

class SchoolServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  SchoolServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  Future<Map<String, dynamic>> getschools({
    required String username,
    required String password,
  }) async {
    return await _apiHelpers.post(
      body: {},
      endpoint: "$username/$password/${_EndpointConstants.getschools}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> fetchSchool({
    required String username,
    required String password,
    required int schoolID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "okulID": schoolID,
      },
      endpoint: "$username/$password/${_EndpointConstants.fetchSchool}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> joinschool({
    required String username,
    required String password,
    required String schoolID,
    required String classID,
    required String jobID,
    required String classPassword,
  }) async {
    return await _apiHelpers.post(
      body: {
        "isyeriidi": schoolID,
        "hangisinif": classID,
        "hangibrans": jobID,
        "sinifsifresi": classPassword,
      },
      endpoint: "$username/$password/${_EndpointConstants.joinschool}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> getschoolclass({
    required String username,
    required String password,
    required String schoolID,
  }) async {
    return await _apiHelpers.post(
      body: {"hangisyeri": schoolID},
      endpoint: "$username/$password/${_EndpointConstants.getschoolclass}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }
}
