part of 'package:armoyu_services/armoyu_services.dart';

class _UserServices {
  String? Function() getToken;
  final _ApiHelpers apiHelpers;

  _UserServices({
    required this.getToken,
    required this.apiHelpers,
  });

  Future<Map<String, dynamic>> getUsers() async {
    return await apiHelpers.get(
      endpoint: _EndpointConstants.users,
      headers: apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> deleteUser({required int userId}) async {
    return await apiHelpers.delete(
      endpoint: '${_EndpointConstants.users}/$userId',
      headers: apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> addFriend({
    required AddFriendRequestModel addFriendRequestModel,
  }) async {
    return await apiHelpers.post(
      endpoint: '${_EndpointConstants.users}/friends',
      headers: apiHelpers.getRequestHeader(
        token: getToken(),
      ),
      body: addFriendRequestModel.toMap(),
    );
  }
}
