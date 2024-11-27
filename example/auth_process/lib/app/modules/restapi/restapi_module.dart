import 'package:auth_process/app/modules/restapi/views/restapi_view.dart';
import 'package:get/get.dart';

class RestapiModule {
  static const route = '/restapi';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const RestapiView(),
    ),
  ];
}
