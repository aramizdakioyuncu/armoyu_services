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

  //Category
  Future<Map<String, dynamic>> category({
    required String username,
    required String password,
    required String categoryID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "kategoriID": categoryID,
      },
      endpoint: "$username/$password/${_EndpointConstants.categories}/0/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> categorydetail({
    required String username,
    required String password,
    required String categoryID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "kategoriID": categoryID,
      },
      endpoint: "$username/$password/${_EndpointConstants.categorydetail}/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

//Category
}
