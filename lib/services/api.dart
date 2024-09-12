import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

class APIServices extends GetConnect {
  final String baseURL = "http://server.aramizdakioyuncu";
  String? _userTOKEN;
  String? _version;
  final String apiKEY;

  APIServices({required this.apiKEY}) {
    if (apiKEY == "") {
      throw ("KEY girilmeden başlanamaz");
    }

    httpClient.baseUrl = "$baseURL/api/v1/$apiKEY/";

    checkplatform();
    checkdevice();
    log("API INITALIZED : $baseURL");
  }

  void setuserTOKEN(String token) {
    _userTOKEN = token;
  }

  Future<void> checkplatform() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    _version = packageInfo.version;
    log(_version.toString());
  }

  checkdevice() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final allInfo = deviceInfo.data;
    log(allInfo.toString());
  }
  //////////////////////////////////USER////////////////////////////////////////////

// Yeni Request ekleme
  Future<Map<String, dynamic>> addfriend({
    required int kiminle,
  }) async {
    Map<String, dynamic> formData = {
      "kiminle": kiminle,
    };
    return await fetch('users/friends', method: 'POST', body: formData);
  }

  //  Request listeleme
  Future<Map<String, dynamic>> getfeedbackrequest() async {
    return await fetch('requests', method: 'GET');
  }

  // Kullanıcıları getirme
  Future<Map<String, dynamic>> getUsers() async {
    return await fetch('users', method: 'GET');
  }

  // Kullanıcı  silme
  Future<Map<String, dynamic>> deleteUser({required int userID}) async {
    return await fetch('users/$userID', method: 'DELETE');
  }

  // Giriş Yapma
  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    Map<String, String> formData = {
      "username": username,
      "password": password,
    };
    Map<String, dynamic> getUsersResult =
        await fetch('login', method: 'POST', body: formData);

    if (getUsersResult['durum'] == 1) {
      _userTOKEN = getUsersResult['icerik']['access_token'];
    }
    return getUsersResult;
  }

  // Çıkış Yapma
  Future<Map<String, dynamic>> logout() async {
    return await fetch('users', method: 'POST', body: null);
  }

// Yeni Request ekleme
  Future<Map<String, dynamic>> register({
    required String firstname,
    required String lastname,
    required String username,
    required String email,
    required String password,
  }) async {
    Map<String, dynamic> formData = {
      "firstname": firstname,
      "lastname": lastname,
      "username": username,
      "email": email,
      "password": password,
    };

    Map<String, dynamic> getUsersResult =
        await fetch('users', method: 'POST', body: formData);

    if (getUsersResult['durum'] == 1) {
      log(getUsersResult['icerik']['access_token']);
    }

    return getUsersResult;
  }
  //////////////////////////////////////////////////////////////////////////////

  Future<Map<String, dynamic>> fetch(String endpoint,
      {String method = 'GET', Map<String, dynamic>? body}) async {
    try {
      log("Tam URL: ${httpClient.baseUrl! + endpoint}");
      Response response;
      if (method == 'POST') {
        response = await post(
          endpoint,
          json.encode(body),
          headers: {
            'Authorization': 'Bearer $_userTOKEN',
            'Content-Type': 'application/json',
            'X-Client-Version': _version!
          },
        );
      } else if (method == 'PUT') {
        response = await put(
          endpoint,
          json.encode(body),
          headers: {
            'Authorization': 'Bearer $_userTOKEN',
            'Content-Type': 'application/json',
            'X-Client-Version': _version!
          },
        );
      } else if (method == 'DELETE') {
        response = await delete(
          endpoint,
          headers: {
            'Authorization': 'Bearer $_userTOKEN',
            'Content-Type': 'application/json',
            'X-Client-Version': _version!
          },
        );
      } else {
        response = await get(
          endpoint,
          headers: {
            'Authorization': 'Bearer $_userTOKEN',
            'Content-Type': 'application/json',
            'X-Client-Version': _version!
          },
        );
      }

      if (response.isOk) {
        Map<String, dynamic> jsonresponse =
            json.decode(response.bodyString.toString());
        log(jsonresponse["aciklama"].toString());

        return jsonresponse;
      } else {
        log("Status hatası: ${response.statusCode}");
        return {
          'durum': false,
          'aciklama': '${response.statusCode} ${response.bodyString ?? ''}',
        };
      }
    } catch (e) {
      log("Sunucuya bağlanılamadı: $e");
      return {
        'durum': false,
        'aciklama': 'Sunucuya bağlanılamadı: $e',
      };
    }
  }
}
