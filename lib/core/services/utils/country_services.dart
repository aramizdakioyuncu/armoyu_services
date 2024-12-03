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

  Future<CountryResponse> countryfetch() async {
    Map<String, dynamic> response = await _apiHelpers.post(
      endpoint: "0/0/${_EndpointConstants.countries}/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    CountryResponse armoyuresponse = CountryResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    armoyuresponse.response = APICountry(
      countryID: response['icerik']['country_ID'],
      name: response['icerik']['country_name'],
      code: response['icerik']['country_code'],
      phonecode: response['icerik']['country_phoneCode'],
    );

    return armoyuresponse;
  }

  Future<ProvinceResponse> fetchprovince({required int countryID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"countryID": countryID},
      endpoint: "0/0/${_EndpointConstants.provinces}/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    ProvinceResponse armoyuresponse = ProvinceResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }
    armoyuresponse.response = APIProvince(
      provinceID: response['icerik']['province_ID'],
      name: response['icerik']['province_name'],
      platecode: response['icerik']['province_plateCode'],
      phonecode: response['icerik']['province_phoneCode'],
    );
    return armoyuresponse;
  }
}
