part of 'package:armoyu_services/armoyu_services.dart';

class ProfileServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  ProfileServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  Future<Map<String, dynamic>> invitelist({
    required String username,
    required String password,
    required int page,
  }) async {
    return await _apiHelpers.post(
      body: {
        "sayfa": page,
        "limit": "30",
      },
      endpoint: "$username/$password/${_EndpointConstants.invitelist}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> sendauthmailURL({
    required String username,
    required String password,
    required int userID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "userID": "$userID",
      },
      endpoint: "$username/$password/${_EndpointConstants.sendauthmail}/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> invitecoderefresh({
    required String username,
    required String password,
  }) async {
    return await _apiHelpers.post(
      body: {},
      endpoint:
          "$username/$password/${_EndpointConstants.invitecoderefresh}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> friendlist({
    required String username,
    required String password,
    required int userID,
    required int page,
  }) async {
    return await _apiHelpers.post(
      body: {
        "oyuncubakid": userID,
        "sayfa": "$page",
        "limit": "50",
      },
      endpoint: "$username/$password/${_EndpointConstants.friendlist}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> friendrequest({
    required String username,
    required String password,
    required int userID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "oyuncubakid": userID,
      },
      endpoint: "$username/$password/${_EndpointConstants.friendrequest}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> friendrequestanswer({
    required String username,
    required String password,
    required int userID,
    required int answer,
  }) async {
    return await _apiHelpers.post(
      body: {
        "oyuncubakid": userID,
        "cevap": answer,
      },
      endpoint:
          "$username/$password/${_EndpointConstants.friendrequestanswer}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> userdurting({
    required String username,
    required String password,
    required int userID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "oyuncubakid": userID,
      },
      endpoint: "$username/$password/${_EndpointConstants.userdurting}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> friendremove({
    required String username,
    required String password,
    required int userID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "oyuncubakid": userID,
      },
      endpoint: "$username/$password/${_EndpointConstants.friendremove}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> defaultavatar({
    required String username,
    required String password,
  }) async {
    return await _apiHelpers.post(
      body: {},
      endpoint: "$username/$password/${_EndpointConstants.defaultavatar}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> defaultbanner({
    required String username,
    required String password,
  }) async {
    return await _apiHelpers.post(
      body: {},
      endpoint: "$username/$password/${_EndpointConstants.defaultbanner}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> changeavatar({
    required String username,
    required String password,
    required List<XFile> files,
  }) async {
    List<http.MultipartFile> photosCollection = [];
    for (var file in files) {
      photosCollection.add(await _apiHelpers.generateImageFile("resim", file));
    }
    return await _apiHelpers.post(
      body: {},
      files: photosCollection,
      endpoint: "$username/$password/${_EndpointConstants.changeavatar}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> changebanner({
    required String username,
    required String password,
    required List<XFile> files,
  }) async {
    List<http.MultipartFile> photosCollection = [];
    for (var file in files) {
      photosCollection.add(await _apiHelpers.generateImageFile("resim", file));
    }
    return await _apiHelpers.post(
      body: {},
      files: photosCollection,
      endpoint: "$username/$password/${_EndpointConstants.changebanner}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> selectfavteam({
    required String username,
    required String password,
    int? teamID,
  }) async {
    return await _apiHelpers.post(
      body: {"favoritakimID": "$teamID"},
      endpoint: "$username/$password/${_EndpointConstants.selectfavteam}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> saveprofiledetails({
    required String username,
    required String password,
    required String firstname,
    required String lastname,
    required String aboutme,
    required String email,
    required String countryID,
    required String provinceID,
    required String birthday,
    required String phoneNumber,
    required String passwordControl,
  }) async {
    return await _apiHelpers.post(
      body: {
        "ad": firstname,
        "soyad": lastname,
        "about": aboutme,
        "hakkimda": lastname,
        "email": email,
        "countryID": countryID,
        "provinceID": provinceID,
        "birthday": birthday,
        "phoneNumber": phoneNumber,
        "passwordControl": passwordControl,
        "v1": "1",
      },
      endpoint:
          "$username/$password/${_EndpointConstants.saveprofiledetails}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }
}
