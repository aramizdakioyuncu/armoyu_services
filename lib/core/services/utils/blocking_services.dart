part of 'package:armoyu_services/armoyu_services.dart';

class BlockingServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  BlockingServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  Future<BlockingListResponse> list({
    required String username,
    required String password,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> response = await _apiHelpers.post(
      endpoint: "$username/$password/${_EndpointConstants.blockinglist}/0/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    BlockingListResponse armoyuresponse = BlockingListResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    armoyuresponse.response = APIBlockingList(
      blockID: response['engel_ID'],
      blockeduser: UserInfo(
        userID: response['engel_kimeID'],
        displayname: response['engel_kime'],
        username: response['engel_kadi'],
        avatar: MediaURL(
          bigURL: response['engel_avatar'],
          normalURL: response['engel_avatar'],
          minURL: response['engel_avatar'],
        ),
      ),
      date: response['engel_zaman'],
    );

    return armoyuresponse;
  }

  Future<BlockingAddResponse> add({
    required String username,
    required String password,
    required int userID,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> response = await _apiHelpers.post(
      endpoint: "$username/$password/${_EndpointConstants.bloclistadd}/0",
      body: {"userID": userID},
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    BlockingAddResponse armoyuresponse = BlockingAddResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    return armoyuresponse;
  }

  Future<BlockingRemoveResponse> remove({
    required String username,
    required String password,
    required int userID,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"userID": userID},
      endpoint: "$username/$password/${_EndpointConstants.bloclistremove}/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    BlockingRemoveResponse armoyuresponse =
        BlockingRemoveResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }
    return armoyuresponse;
  }
}
