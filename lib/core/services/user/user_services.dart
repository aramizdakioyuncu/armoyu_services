import 'package:armoyu_services/export.dart';

class UserServices {
  final String? token;
  final String? appVersion;
  final ApiHelpers apiHelpers;

  UserServices({
    required this.token,
    required this.appVersion,
    required this.apiHelpers,
  });

  Future<Map<String, dynamic>> getUsers() async {
    return await apiHelpers.get(
      endpoint: EndpointConstants.users,
      headers: apiHelpers.getRequestHeader(
        token: token,
        appVersion: appVersion,
      ),
    );
  }

  Future<Map<String, dynamic>> deleteUser({required int userId}) async {
    return await apiHelpers.delete(
      endpoint: '${EndpointConstants.users}/$userId',
      headers: apiHelpers.getRequestHeader(
        token: token,
        appVersion: appVersion,
      ),
    );
  }

  Future<Map<String, dynamic>> addFriend({
    required AddFriendRequestModel addFriendRequestModel,
  }) async {
    return await apiHelpers.post(
      endpoint: '${EndpointConstants.users}/friends',
      body: addFriendRequestModel.toMap(),
    );
  }
}
