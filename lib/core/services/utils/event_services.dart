part of 'package:armoyu_services/armoyu_services.dart';

class EventServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  EventServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  //Events

  Future<Map<String, dynamic>> fetch({
    required String username,
    required String password,
  }) async {
    return await _apiHelpers.post(
      body: {},
      endpoint: "$username/$password/${_EndpointConstants.eventlist}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> detailfetch({
    required String username,
    required String password,
    required int eventID,
  }) async {
    return await _apiHelpers.post(
      body: {},
      endpoint:
          "$username/$password/${_EndpointConstants.eventdetail}/$eventID/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> joinOrleave({
    required String username,
    required String password,
    required int eventID,
    required bool status,
  }) async {
    int intStatus = 0;

    if (status) {
      intStatus = 1;
    }

    return await _apiHelpers.post(
      body: {
        "etkinlikID": "$eventID",
        "cevap": intStatus,
      },
      endpoint: "$username/$password/${_EndpointConstants.joinleave}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> participantList({
    required String username,
    required String password,
    required int eventID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "etkinlikID": "$eventID",
      },
      endpoint: "$username/$password/${_EndpointConstants.participant}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }
//Events
}
