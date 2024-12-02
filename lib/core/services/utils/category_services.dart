part of 'package:armoyu_services/armoyu_services.dart';

class CategoryServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  CategoryServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  Future<CategoryResponse> category({
    required String username,
    required String password,
    required String categoryID,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "kategoriID": categoryID,
      },
      endpoint: "$username/$password/${_EndpointConstants.categories}/0/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    CategoryResponse armoyuresponse = CategoryResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    armoyuresponse.response = APICategory(
      categoryID: response['icerik']['kategori_ID'],
      name: response['icerik']['kategori_adi'],
    );
    return armoyuresponse;
  }

  Future<CategoryResponse> categorydetail({
    required String username,
    required String password,
    required String categoryID,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "kategoriID": categoryID,
      },
      endpoint: "$username/$password/${_EndpointConstants.categorydetail}/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    CategoryResponse armoyuresponse = CategoryResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    armoyuresponse.response = APICategory(
      categoryID: response['icerik']['kategori_ID'],
      name: response['icerik']['kategori_adi'],
    );
    return armoyuresponse;
  }
}
