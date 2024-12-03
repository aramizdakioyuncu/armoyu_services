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

  Future<ServiceResult> getschools() async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {},
      endpoint: "0/0/${_EndpointConstants.getschools}/0/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    if (response['durum'] == 0) {
      return result;
    }
    return result;
  }

  Future<ServiceResult> fetchSchool({
    required int schoolID,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"okulID": schoolID},
      endpoint: "0/0/${_EndpointConstants.fetchSchool}/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    if (response['durum'] == 0) {
      return result;
    }
    return result;
  }

  Future<ServiceResult> joinschool({
    required String schoolID,
    required String classID,
    required String jobID,
    required String classPassword,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "isyeriidi": schoolID,
        "hangisinif": classID,
        "hangibrans": jobID,
        "sinifsifresi": classPassword,
      },
      endpoint: "0/0/${_EndpointConstants.joinschool}/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    if (response['durum'] == 0) {
      return result;
    }
    return result;
  }

  Future<ServiceResult> getschoolclass({required String schoolID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"hangisyeri": schoolID},
      endpoint: "0/0/${_EndpointConstants.getschoolclass}/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    if (response['durum'] == 0) {
      return result;
    }
    return result;
  }
}
