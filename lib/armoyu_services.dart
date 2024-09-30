library armoyu_services.dart;

import 'package:armoyu_services/export.dart';
export 'package:armoyu_services/export.dart';
import 'package:http/http.dart' as http;

part 'core/services/logging/logging_services.dart';
part 'core/services/auth/auth_services.dart';
part 'core/services/user/user_services.dart';
part 'core/services/utils/utils_services.dart';
part 'core/helpers/api_helpers.dart';
part 'core/constants/endpoint_constants.dart';

class ARMOYUServices {
  late final AuthServices authServices;
  late final UserServices userServices;
  late final UtilsServices utilsServices;

  final String apiKey;

  String? _token;
  String? get _getToken => _token;
  set token(String? value) => _token = value;

  ARMOYUServices({required this.apiKey, bool usePreviousAPI = false}) {
    authServices = AuthServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );

    userServices = UserServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );

    utilsServices = UtilsServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );
  }

  Future<void> setup() async {
    await _LoggingServices.instance.setup();
  }
}
