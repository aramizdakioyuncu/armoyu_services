part of 'package:armoyu_services/armoyu_services.dart';

final class _LoggingServices {
  static final _LoggingServices _instance = _LoggingServices._init();
  static _LoggingServices get instance => _instance;

  String? _version;
  String? get version => _version;

  Map<String, dynamic>? _deviceInfo;

  _LoggingServices._init() {
    logConsole(message: "API Initialized");
  }

  Future<void> setup() async {
    await getAppVersion();
    await getDeviceInfo();
  }

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    _version = packageInfo.version;
    logConsole(message: "App Version: $_version");
  }

  Future<void> getDeviceInfo() async {
    final deviceInfo = await DeviceInfoPlugin().deviceInfo;
    _deviceInfo = deviceInfo.data;
    logConsole(message: "Device Info: $_deviceInfo");
  }

  void logConsole({required String message}) {
    log("[ARMOYU]: $message");
  }
}
