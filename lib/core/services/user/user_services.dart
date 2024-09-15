import 'package:armoyu_services/export.dart';

class UserServices {
  late final ApiHelpers _apiHelpers;

  final String? token;
  final String? appVersion;

  UserServices({
    required this.token,
    required this.appVersion,
  }) {
    _apiHelpers = ApiHelpers();
  }

  Future<Map<String, dynamic>> getUsers() async {
    return await _apiHelpers.get(
      endpoint: EndpointConstants.users,
      headers: _apiHelpers.getRequestHeader(
        token: token,
        appVersion: appVersion,
      ),
    );
  }

  Future<Map<String, dynamic>> deleteUser({required int userId}) async {
    return await _apiHelpers.delete(
      endpoint: '${EndpointConstants.users}/$userId',
      headers: _apiHelpers.getRequestHeader(
        token: token,
        appVersion: appVersion,
      ),
    );
  }

  Future<Map<String, dynamic>> addFriend({
    required AddFriendRequestModel addFriendRequestModel,
  }) async {
    return await _apiHelpers.post(
      endpoint: '${EndpointConstants.users}/friends',
      body: addFriendRequestModel.toMap(),
    );
  }
}
