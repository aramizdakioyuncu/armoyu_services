part of 'package:armoyu_services/armoyu_services.dart';

class _UtilsServices {
  String? Function() getToken;
  final _ApiHelpers apiHelpers;

  _UtilsServices({
    required this.getToken,
    required this.apiHelpers,
  });

  //  Request listeleme
  Future<Map<String, dynamic>> getFeedbackRequest() async {
    return await apiHelpers.get(
      endpoint: _EndpointConstants.requests,
      headers: apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }
}
