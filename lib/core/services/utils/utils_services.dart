import 'package:armoyu_services/export.dart';

class UtilsServices {
  final String? token;
  final String? appVersion;
  final ApiHelpers apiHelpers;

  UtilsServices({
    required this.token,
    required this.appVersion,
    required this.apiHelpers,
  });

  //  Request listeleme
  Future<Map<String, dynamic>> getFeedbackRequest() async {
    return await apiHelpers.get(
      endpoint: EndpointConstants.requests,
      headers: apiHelpers.getRequestHeader(
        token: token,
        appVersion: appVersion,
      ),
    );
  }
}
