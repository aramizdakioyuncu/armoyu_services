import 'package:auth_process/app/modules/restapi/_main/views/restapi_view.dart';
import 'package:auth_process/app/modules/restapi/events/views/events_view.dart';
import 'package:auth_process/app/modules/restapi/gallery/views/gallery_detail_view.dart';
import 'package:auth_process/app/modules/restapi/gallery/views/gallery_view.dart';
import 'package:auth_process/app/modules/restapi/group/views/group_view.dart';
import 'package:auth_process/app/modules/restapi/login/views/login_view.dart';
import 'package:auth_process/app/modules/restapi/news/views/news_view.dart';
import 'package:auth_process/app/modules/restapi/other/views/other_view.dart';
import 'package:auth_process/app/modules/restapi/profile/views/profile_view.dart';
import 'package:auth_process/app/modules/restapi/register/views/register_view.dart';
import 'package:auth_process/app/modules/restapi/searchengine/views/search_engine_view.dart';
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
    GetPage(
      name: "$route/register",
      page: () => const RegisterView(),
    ),
    GetPage(
      name: "$route/profile",
      page: () => const ProfileView(),
    ),
    GetPage(
      name: "$route/news",
      page: () => const NewsView(),
    ),
    GetPage(
      name: "$route/other",
      page: () => const OtherView(),
    ),
    GetPage(
      name: "$route/search-engine",
      page: () => const SearchEngineView(),
    ),
    GetPage(
      name: "$route/groups",
      page: () => const GroupView(),
    ),
    GetPage(
      name: "$route/gallery",
      page: () => const GalleryView(),
    ),
    GetPage(
      name: "$route/gallery/:gallery",
      page: () => const GalleryDetailView(),
    ),
    GetPage(
      name: "$route/events",
      page: () => const EventsView(),
    ),
  ];
}
