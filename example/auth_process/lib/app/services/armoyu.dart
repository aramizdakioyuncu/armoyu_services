import 'package:armoyu_services/armoyu_services.dart';
import 'package:armoyu_services/widgets/widget.dart';

class ARMOYU {
  static ARMOYUServices service = ARMOYUServices(
    apiKey: "",
    usePreviousAPI: true,
  );

  static ARMOYUWidget widgets = ARMOYUWidget(service: service);
}
