part of 'package:armoyu_services/armoyu_services.dart';

class StationServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  StationServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  Future<Map<String, dynamic>> fetchStations({
    required String username,
    required String password,
  }) async {
    return await _apiHelpers.post(
      body: {},
      endpoint: "$username/$password/${_EndpointConstants.stations}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> fetchfoodstation({
    required String username,
    required String password,
  }) async {
    return await _apiHelpers.post(
      body: {"kategori": "yemek"},
      endpoint: "$username/$password/${_EndpointConstants.stations}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> fetchEquipments({
    required String username,
    required String password,
    required int stationID,
  }) async {
    return await _apiHelpers.post(
      body: {"istasyonID": stationID},
      endpoint:
          "$username/$password/${_EndpointConstants.stationequipments}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }
}
