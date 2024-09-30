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
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/$apiKey/$endpoint"),
      headers: headers,
      body: body != null ? json.encode(body) : null,
    );

    return _defaultCallback(response: response);
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
      Map<String, dynamic> jsonresponse = json.decode(response.body);
      _LoggingServices.instance.logConsole(
        message: jsonresponse["aciklama"].toString(),
      );

      return jsonresponse;
    } else {
      _LoggingServices.instance.logConsole(
        message: "Status hatası: ${response.statusCode}",
      );
      return {
        'durum': false,
        'aciklama': '${response.statusCode} ${response.body}',
      };
    }
  }
}
