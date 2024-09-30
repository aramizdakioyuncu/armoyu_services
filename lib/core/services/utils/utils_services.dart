part of 'package:armoyu_services/armoyu_services.dart';

class UtilsServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  UtilsServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  //  Request listeleme
  Future<Map<String, dynamic>> getFeedbackRequest() async {
    return await _apiHelpers.get(
      endpoint: _EndpointConstants.requests,
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }
}
