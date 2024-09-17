import 'package:armoyu_services/export.dart';

class UtilsServices {
  String? token;
  String? appVersion;
  final ApiHelpers apiHelpers;

  UtilsServices({
    required this.token,
    required this.appVersion,
    required this.apiHelpers,
  });

  void reload({required String? t, required String? a}) {
    token = t;
    appVersion = a;
  }

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
