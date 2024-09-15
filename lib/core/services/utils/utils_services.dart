import 'package:armoyu_services/export.dart';

class UtilsServices {
  late final ApiHelpers _apiHelpers;

  final String? token;
  final String? appVersion;

  UtilsServices({
    required this.token,
    required this.appVersion,
  }) {
    _apiHelpers = ApiHelpers();
  }

  //  Request listeleme
  Future<Map<String, dynamic>> getFeedbackRequest() async {
    return await _apiHelpers.get(
      endpoint: EndpointConstants.requests,
      headers: _apiHelpers.getRequestHeader(
        token: token,
        appVersion: appVersion,
      ),
    );
  }
}
