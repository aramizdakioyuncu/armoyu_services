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

  Future<Map<String, dynamic>> listNotificationSettings({
    required String username,
    required String password,
  }) async {
    password = _apiHelpers.generateMd5(password);

    return await _apiHelpers.post(
      body: {},
      endpoint:
          "$username/$password/${_EndpointConstants.notificationsettings}/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> updateNotificationSettings({
    required String username,
    required String password,
    required List<String> options,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, String> formData = {};

    for (int i = 0; i < options.length; i++) {
      formData['notification[$i]'] = options[i];
    }
    return await _apiHelpers.post(
      body: formData,
      endpoint:
          "$username/$password/${_EndpointConstants.notificationsettingsupdate}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }
}
