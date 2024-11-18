part of 'package:armoyu_services/armoyu_services.dart';

final class ApiHelpers {
  final String apiKey;
  final bool usePreviousAPI;

  late final String baseUrl;

  ApiHelpers({required this.apiKey, required this.usePreviousAPI}) {
    baseUrl = usePreviousAPI
        ? _EndpointConstants.previousBaseUrl
        : _EndpointConstants.baseURL;
  }

  ///////////////
  Future<XFile> compressImage(XFile image) async {
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = '${dir.absolute.path}/temp.jpg';

    final originaldata = await image.readAsBytes();
    final originalnewkb = originaldata.length / 1024;
    final originalnewMb = originalnewkb / 1024;

    if (kDebugMode) {
      print('original images size : $originalnewMb');
    }

    final result = await FlutterImageCompress.compressAndGetFile(
      image.path,
      targetPath,
      minHeight: 500,
      minWidth: 500,
      quality: 90,
    );

    final data = await result!.readAsBytes();
    final newkb = data.length / 1024;
    final newMb = newkb / 1024;

    if (kDebugMode) {
      print('compress images size : $newMb');
    }

    return XFile(result.path);
  }

  Future<http.MultipartFile> generateImageFile(String text, XFile file) async {
    final fileBytes = await file.readAsBytes();
    return http.MultipartFile.fromBytes(text, fileBytes, filename: file.name);
  }

/////////////////

  Map<String, String> getRequestHeader({
    String? token,
  }) {
    final map = {
      'Authorization': token != null ? 'Bearer $token' : '',
      'Content-Type': 'application/json',
      'X-Client-Version': _LoggingServices.instance.version ?? '',
    };

    map.removeWhere((k, v) => v.trim() == '' || v.trim().isEmpty);
    return map;
  }

  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    final response = await http.get(
      Uri.parse("$baseUrl/$apiKey/$endpoint"),
      headers: headers,
    );

    return _defaultCallback(response: response);
  }

  Future<Map<String, dynamic>> post({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    List<http.MultipartFile>? files,
  }) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("$baseUrl/$apiKey/$endpoint"));
    // Files listesini işleyin
    if (files != null) {
      for (var file in files) {
        request.files.add(file);
      }
    }

    // Header'ları ekle
    if (headers != null) {
      request.headers.addAll(headers);
    }

    // Body'yi ekle (varsa)
    if (body != null) {
      for (var key in body.keys) {
        request.fields[key] = body[key];
      }
    }

    // final response = await http.post(
    //   Uri.parse("$baseUrl/$apiKey/$endpoint"),
    //   headers: headers,
    //   body: body != null ? json.encode(body) : null,
    // );
    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return _defaultCallback(response: response);
    } catch (e) {
      log("[ARMOYU] Sunucuya bağlanılamadı.");
      return {
        "durum": 0,
        "aciklama": "[ARMOYU] Sunucuya bağlanılamadı.",
        "aciklamadetay": ""
      };
    }
  }

  Future<Map<String, dynamic>> put({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$apiKey/$endpoint"),
      headers: headers,
      body: body != null ? json.encode(body) : null,
    );

    return _defaultCallback(response: response);
  }

  Future<Map<String, dynamic>> delete({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/$apiKey/$endpoint"),
      headers: headers,
    );

    return _defaultCallback(response: response);
  }

  Map<String, dynamic> _defaultCallback({required http.Response response}) {
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> jsonresponse = json.decode(response.body);
        _LoggingServices.instance.logConsole(
          message: jsonresponse["aciklama"].toString(),
        );
        return jsonresponse;
      } catch (e) {
        return {
          "durum": 0,
          "aciklama": "[ARMOYU] Json verisi gelmedi.",
          "aciklamadetay": ""
        };
      }
    } else {
      _LoggingServices.instance.logConsole(
        message: "Status hatası: ${response.statusCode}",
      );
      return {
        "durum": 0,
        "aciklama":
            "[ARMOYU] İstek başarısız oldu. Durum kodu: ${response.statusCode}",
        "aciklamadetay": ""
      };
    }
  }
}
