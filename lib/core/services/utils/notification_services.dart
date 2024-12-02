part of 'package:armoyu_services/armoyu_services.dart';

class NotificationServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  NotificationServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  Future<ServiceResult> listNotificationSettings({
    required String username,
    required String password,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> response = await _apiHelpers.post(
      body: {},
      endpoint:
          "$username/$password/${_EndpointConstants.notificationsettings}/",
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

  Future<ServiceResult> updateNotificationSettings({
    required String username,
    required String password,
    required List<String> options,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, String> formData = {};

    for (int i = 0; i < options.length; i++) {
      formData['notification[$i]'] = options[i];
    }
    Map<String, dynamic> response = await _apiHelpers.post(
      body: formData,
      endpoint:
          "$username/$password/${_EndpointConstants.notificationsettingsupdate}/0/",
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
