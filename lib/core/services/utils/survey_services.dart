part of 'package:armoyu_services/armoyu_services.dart';

class SurveyServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  SurveyServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  Future<ServiceResult> fetchSurveys({
    required String username,
    required String password,
    required int page,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "sayfa": page,
      },
      endpoint: "$username/$password/${_EndpointConstants.surveylist}/0/",
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

  Future<ServiceResult> fetchSurvey({
    required String username,
    required String password,
    required int surveyID,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "anketID": surveyID,
      },
      endpoint: "$username/$password/${_EndpointConstants.surveylist}/0/",
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

  Future<ServiceResult> answerSurvey({
    required String username,
    required String password,
    required int surveyID,
    required int optionID,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "anketID": surveyID,
        "secenekID": optionID,
      },
      endpoint: "$username/$password/${_EndpointConstants.surveyreply}/0/",
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

  Future<ServiceResult> deleteSurvey({
    required String username,
    required String password,
    required int surveyID,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "anketID": surveyID,
      },
      endpoint: "$username/$password/${_EndpointConstants.deletesurvey}/0/",
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

  Future<ServiceResult> createSurvey({
    required String username,
    required String password,
    required String surveyQuestion,
    required List<String> options,
    required String date,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, String> formData = {
      "anketsoru": surveyQuestion,
      "bitiszaman": date,
      "kime": "0",
    };

    for (int i = 0; i < options.length; i++) {
      formData['secenekler[$i]'] = options[i];
    }

    Map<String, dynamic> response = await _apiHelpers.post(
      body: formData,
      endpoint: "$username/$password/${_EndpointConstants.createsurvey}/0/",
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
