import 'package:auth_process/app/modules/restapi/_main/views/restapi_view.dart';
import 'package:auth_process/app/modules/restapi/login/views/login_view.dart';
import 'package:get/get.dart';

class RestapiModule {
  static const route = '/restapi';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const RestapiView(),
    ),
    GetPage(
      name: "$route/login",
      page: () => const LoginView(),
    ),
  ];
}
