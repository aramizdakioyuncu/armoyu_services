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

  Future<JoinUsFetchDepartmentsResponse> fetchdepartment() async {
    Map<String, dynamic> response = await _apiHelpers.post(
      endpoint: "0/0/${_EndpointConstants.permissions}/0/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    JoinUsFetchDepartmentsResponse armoyuresponse =
        JoinUsFetchDepartmentsResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    return armoyuresponse;
  }

  Future<JoinUsApplicationsResponse> applicationList(
      {required int page}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "sayfa": page,
      },
      endpoint: "0/0/${_EndpointConstants.applicationList}/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    JoinUsApplicationsResponse armoyuresponse =
        JoinUsApplicationsResponse(result: result);
    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    return armoyuresponse;
  }

  Future<JoinUsRequestJoinDepartmentResponse> requestjoindepartment({
    required int positionID,
    required String whyjoin,
    required String whyposition,
    required String howmachtime,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "positionID": "$positionID",
        "whyjoin": whyjoin,
        "whyposition": whyposition,
        "howmachtime": howmachtime,
      },
      endpoint: "0/0/${_EndpointConstants.requestjoindepertment}/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    JoinUsRequestJoinDepartmentResponse armoyuresponse =
        JoinUsRequestJoinDepartmentResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    return armoyuresponse;
  }
}
