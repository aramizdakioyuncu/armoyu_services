import 'package:armoyu_services/core/models/ARMOYU/API/blocking/blocking_add.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/blocking/blocking_remove.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/blocking/blocking_list.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/category/category.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/country&province/country.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/country&province/province.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/event/event.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/event/event_detail.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/event/event_joinorleave.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/event/event_participant.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/group/group_detail.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/group/group_list.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/group/group_user.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/login&register&password/login.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/news/news_list.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/search/search_hashtaglist.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/search/search_list.dart';
import 'package:armoyu_services/core/models/ARMOYU/_response/service_result.dart';
import 'package:armoyu_services/core/models/ARMOYU/sitemessage.dart';

class SitemessageResponse {
  final ServiceResult result;
  Sitemessage? response;
  SitemessageResponse({required this.result, this.response});
}

// #Blocking
class BlockingListResponse {
  final ServiceResult result;
  APIBlockingList? response;
  BlockingListResponse({required this.result, this.response});
}

class BlockingAddResponse {
  final ServiceResult result;
  APIBlockingAdd? response;
  BlockingAddResponse({required this.result, this.response});
}

class BlockingRemoveResponse {
  final ServiceResult result;
  APIBlockingRemove? response;
  BlockingRemoveResponse({required this.result, this.response});
}

// #Category
class CategoryResponse {
  final ServiceResult result;
  APICategory? response;
  CategoryResponse({required this.result, this.response});
}

// #Country
class CountryResponse {
  final ServiceResult result;
  APICountry? response;
  CountryResponse({required this.result, this.response});
}

// #Province
class ProvinceResponse {
  final ServiceResult result;
  APIProvince? response;
  ProvinceResponse({required this.result, this.response});
}

// #Event
class EventResponse {
  final ServiceResult result;
  APIEvent? response;
  EventResponse({required this.result, this.response});
}

class EventDetailResponse {
  final ServiceResult result;
  APIEventDetail? response;
  EventDetailResponse({required this.result, this.response});
}

class EventJoinorLeaveResponse {
  final ServiceResult result;
  APIEventJoinorleave? response;
  EventJoinorLeaveResponse({required this.result, this.response});
}

class EventParticipantResponse {
  final ServiceResult result;
  APIEventParticipant? response;
  EventParticipantResponse({required this.result, this.response});
}

// #Group
class GroupListResponse {
  final ServiceResult result;
  APIGroupList? response;
  GroupListResponse({required this.result, this.response});
}

class GroupDetailResponse {
  final ServiceResult result;
  APIGroupDetail? response;
  GroupDetailResponse({required this.result, this.response});
}

class GroupUsersResponse {
  final ServiceResult result;
  APIGroupUser? response;
  GroupUsersResponse({required this.result, this.response});
}

class GroupLeaveResponse {
  final ServiceResult result;
  APIGroupUser? response;
  GroupLeaveResponse({required this.result, this.response});
}

class GroupSettingsResponse {
  final ServiceResult result;
  APIGroupUser? response;
  GroupSettingsResponse({required this.result, this.response});
}

// #News

class NewsListResponse {
  final ServiceResult result;
  APINewsList? response;
  NewsListResponse({required this.result, this.response});
}

// #Search

class SearchListResponse {
  final ServiceResult result;
  APISearchList? response;
  SearchListResponse({required this.result, this.response});
}

class SearchHashtagListResponse {
  final ServiceResult result;
  APISearchHashtagList? response;
  SearchHashtagListResponse({required this.result, this.response});
}

//login Register Forgotmy password

class LoginResponse {
  final ServiceResult result;
  APILogin? response;
  LoginResponse({required this.result, this.response});
}

class RegisterResponse {
  final ServiceResult result;
  RegisterResponse({required this.result});
}
//Look Profile

class LookProfileResponse {
  final ServiceResult result;
  APILogin? response;
  LookProfileResponse({required this.result, this.response});
}

class LookProfilewithUsernameResponse {
  final ServiceResult result;
  APILogin? response;
  LookProfilewithUsernameResponse({required this.result, this.response});
}
