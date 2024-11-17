library armoyu_services.dart;

import 'package:armoyu_services/export.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
export 'package:armoyu_services/export.dart';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart' as path_provider;

part 'core/services/logging/logging_services.dart';
part 'core/services/auth/auth_services.dart';
part 'core/services/user/user_services.dart';

part 'core/services/utils/app_services.dart';
part 'core/services/utils/blocking_services.dart';
part 'core/services/utils/category_services.dart';
part 'core/services/utils/country_services.dart';
part 'core/services/utils/event_services.dart';
part 'core/services/utils/group_services.dart';

part 'core/services/utils/joinus_services.dart';
part 'core/services/utils/loginregister_services.dart';
part 'core/services/utils/media_services.dart';
part 'core/services/utils/news_services.dart';
part 'core/services/utils/notification_services.dart';
part 'core/services/utils/posts_services.dart';
part 'core/services/utils/profile_services.dart';
part 'core/services/utils/school_services.dart';
part 'core/services/utils/search_services.dart';
part 'core/services/utils/station_services.dart';
part 'core/services/utils/story_services.dart';
part 'core/services/utils/survey_services.dart';
part 'core/services/utils/teams_services.dart';

part 'core/services/utils/utils_services.dart';
part 'core/helpers/api_helpers.dart';
part 'core/constants/endpoint_constants.dart';

class ARMOYUServices {
  late final AuthServices authServices;
  late final UserServices userServices;
  late final UtilsServices utilsServices;

  late final AppServices appServices;
  late final BlockingServices blockingServices;
  late final CategoryServices categoryServices;
  late final CountryServices countryServices;
  late final EventServices eventServices;
  late final GroupServices groupServices;

  late final JoinUsServices joinusServices;
  late final LoginRegisterServices loginRegisterServices;
  late final MediaServices mediaServices;
  late final NewsServices newsServices;
  late final NotificationServices notificationServices;
  late final PostsServices postsServices;
  late final ProfileServices profileServices;
  late final SchoolServices schoolServices;
  late final SearchServices searchServices;
  late final StationServices stationServices;
  late final StoryServices storyServices;
  late final SurveyServices surveyServices;
  late final TeamsServices teamsServices;

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

    appServices = AppServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );

    blockingServices = BlockingServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );

    categoryServices = CategoryServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );

    countryServices = CountryServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );

    eventServices = EventServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );

    groupServices = GroupServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );
//

    joinusServices = JoinUsServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );

    loginRegisterServices = LoginRegisterServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );

    mediaServices = MediaServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );

    newsServices = NewsServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );

    notificationServices = NotificationServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );

    postsServices = PostsServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );

    profileServices = ProfileServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );

    schoolServices = SchoolServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );

    searchServices = SearchServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );

    stationServices = StationServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );

    storyServices = StoryServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );

    surveyServices = SurveyServices(
      getToken: () => _getToken,
      setToken: (String? tkn) => token = tkn,
      apiKey: apiKey,
      usePreviousAPI: usePreviousAPI,
    );

    teamsServices = TeamsServices(
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
