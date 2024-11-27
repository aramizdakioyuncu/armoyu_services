import 'package:auth_process/app/modules/forms/form_module.dart';
import 'package:auth_process/app/modules/home/home_module.dart';
import 'package:auth_process/app/modules/restapi/restapi_module.dart';

class AppPages {
  static const initial = HomeModule.route;

  static final routes = [
    ...HomeModule.routes,

    //Form
    ...FormModule.routes,
    ...RestapiModule.routes,
  ];
}
