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

  Future<Map<String, dynamic>> changegroupmedia({
    required String username,
    required String password,
    required List<XFile> files,
    required int groupID,
    required String category,
  }) async {
    List<http.MultipartFile> photosCollection = [];
    for (var file in files) {
      photosCollection.add(await _apiHelpers.generateImageFile("media", file));
    }

    return await _apiHelpers.post(
      body: {
        "groupID": "$groupID",
        "category": category,
      },
      endpoint: "$username/$password/${_EndpointConstants.groupsettings}/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
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

  Future<Map<String, dynamic>> sitemesaji({
    required String username,
    required String password,
  }) async {
    return await _apiHelpers.post(
      endpoint: "$username/$password/${_EndpointConstants.chat}/0/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

//Blocking
  Future<Map<String, dynamic>> blockinglist({
    required String username,
    required String password,
  }) async {
    return await _apiHelpers.post(
      endpoint: "$username/$password/${_EndpointConstants.blockinglist}/0/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> blocklistadd({
    required String username,
    required String password,
    required int userID,
  }) async {
    return await _apiHelpers.post(
        endpoint: "$username/$password/${_EndpointConstants.bloclistadd}/0",
        headers: _apiHelpers.getRequestHeader(
          token: getToken(),
        ),
        body: {"userID": userID});
  }

  Future<Map<String, dynamic>> blocklistremove({
    required String username,
    required String password,
    required int userID,
  }) async {
    return await _apiHelpers.post(
        endpoint: "$username/$password/${_EndpointConstants.bloclistremove}/0",
        headers: _apiHelpers.getRequestHeader(
          token: getToken(),
        ),
        body: {"userID": userID});
  }

//Blocking

//Category
  Future<Map<String, dynamic>> category({
    required String username,
    required String password,
    required int categoryID,
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
    required int categoryID,
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

//Country - Province

  Future<Map<String, dynamic>> countryfetch({
    required String username,
    required String password,
  }) async {
    return await _apiHelpers.post(
      body: {},
      endpoint: "$username/$password/${_EndpointConstants.countries}/0/0",
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
    return await _apiHelpers.post(
      body: {"countryID": countryID},
      endpoint: "$username/$password/${_EndpointConstants.provinces}/0/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

//Country - Province

//Events

  Future<Map<String, dynamic>> eventsfetch({
    required String username,
    required String password,
  }) async {
    return await _apiHelpers.post(
      body: {},
      endpoint: "$username/$password/${_EndpointConstants.eventlist}/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> eventsdetail({
    required String username,
    required String password,
    required int eventID,
  }) async {
    return await _apiHelpers.post(
      body: {},
      endpoint:
          "$username/$password/${_EndpointConstants.eventdetail}/$eventID/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> eventJoinorLeave({
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
      endpoint: "$username/$password/${_EndpointConstants.joinleave}/0/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> eventparticipantList({
    required String username,
    required String password,
    required int eventID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "etkinlikID": "$eventID",
      },
      endpoint: "$username/$password/${_EndpointConstants.participant}/0/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }
//Events
//Group

  Future<Map<String, dynamic>> groupFetch({
    required String username,
    required String password,
    required int grupID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "grupID": grupID,
      },
      endpoint: "$username/$password/${_EndpointConstants.groups}/0/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> groupusersFetch({
    required String username,
    required String password,
    required int grupID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "grupID": grupID,
      },
      endpoint: "$username/$password/${_EndpointConstants.groupmembers}/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> groupLeave({
    required String username,
    required String password,
    required int grupID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "grupID": grupID,
      },
      endpoint: "$username/$password/${_EndpointConstants.groupleave}/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> groupsettingsSave({
    required String username,
    required String password,
    required int grupID,
    required String groupName,
    required String groupshortName,
    required String description,
    required String discordInvite,
    required String webLINK,
    required bool joinStatus,
  }) async {
    return await _apiHelpers.post(
      body: {
        "grupID": "$grupID",
        "baslik": groupName,
        "grupetiket": groupshortName,
        "aciklama": description,
        "discordlink": discordInvite,
        "website": webLINK,
        "alimdurum": joinStatus == true ? "1" : "0",
      },
      endpoint: "$username/$password/${_EndpointConstants.groupsettings}/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> grouprequestanswer({
    required String username,
    required String password,
    required int groupID,
    required String answer,
  }) async {
    return await _apiHelpers.post(
      body: {
        "grupID": "$groupID",
        "cevap": answer,
      },
      endpoint:
          "$username/$password/${_EndpointConstants.groupInviteanswer}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> groupuserInvite({
    required String username,
    required String password,
    required int groupID,
    required List<String> userList, //Username
  }) async {
    Map<String, String> formData = {"grupID": "$groupID"};
    for (int i = 0; i < userList.length; i++) {
      formData['users[$i]'] = userList[i];
    }

    return await _apiHelpers.post(
      body: formData,
      endpoint: "$username/$password/${_EndpointConstants.groupInvite}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> groupuserRemove({
    required String username,
    required String password,
    required int groupID,
    required int userID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "grupID": groupID,
        "userID": userID,
      },
      endpoint: "$username/$password/${_EndpointConstants.groupuserremove}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> groupcreate({
    required String username,
    required String password,
    required String grupadi,
    required String kisaltmaadi,
    required int grupkategori,
    required int grupkategoridetay,
    required int varsayilanoyun,
  }) async {
    return await _apiHelpers.post(
      body: {
        "grupadi": grupadi,
        "kisaltmaadi": kisaltmaadi,
        "grupkategori": "$grupkategori",
        "grupkategoridetay": "$grupkategoridetay",
        "varsayilanoyun": "$varsayilanoyun"
      },
      endpoint: "$username/$password/${_EndpointConstants.groupcreate}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  //Group
}
