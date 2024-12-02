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

  Future<ServiceResult> fetchdepartment({
    required String username,
    required String password,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> response = await _apiHelpers.post(
      endpoint: "$username/$password/${_EndpointConstants.permissions}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
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

  Future<ServiceResult> applicationList({
    required String username,
    required String password,
    required int page,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "sayfa": page,
      },
      endpoint: "$username/$password/${_EndpointConstants.applicationList}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
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

  Future<ServiceResult> requestjoindepartment({
    required String username,
    required String password,
    required int positionID,
    required String whyjoin,
    required String whyposition,
    required String howmachtime,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> response = await _apiHelpers.post(
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
