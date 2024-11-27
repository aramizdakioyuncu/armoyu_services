part of 'package:armoyu_services/armoyu_services.dart';

class CountryServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  CountryServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  //Country - Province

  Future<Map<String, dynamic>> countryfetch({
    required String username,
    required String password,
  }) async {
    password = _apiHelpers.generateMd5(password);

    return await _apiHelpers.post(
      body: {},
      endpoint: "$username/$password/${_EndpointConstants.countries}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> fetchprovince({
    required String username,
    required String password,
    required int countryID,
  }) async {
    password = _apiHelpers.generateMd5(password);

    return await _apiHelpers.post(
      body: {"countryID": countryID},
      endpoint: "$username/$password/${_EndpointConstants.provinces}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

//Country - Province
}
