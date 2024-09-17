import 'package:armoyu_services/export.dart';

final class LoggingServices {
  String? _version;
  String? get version => _version;

  Map<String, dynamic>? _deviceInfo;

  LoggingServices() {
    logConsole(message: "API Initialized");

    getAppVersion();
    getDeviceInfo();
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
    log("[ARMOYU] $message");
  }
}
