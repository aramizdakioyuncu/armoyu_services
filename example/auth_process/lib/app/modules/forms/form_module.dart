import 'package:auth_process/app/modules/forms/views/form_view.dart';
import 'package:get/get.dart';

class FormModule {
  static const route = '/forms';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const FormView(),
    ),
  ];
}
