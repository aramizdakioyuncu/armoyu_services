part of 'package:armoyu_services/armoyu_services.dart';

final class _EndpointConstants {
  static const String baseURL = "http://server.aramizdakioyuncu/api/v1";
  static const String previousBaseUrl = "https://aramizdakioyuncu.com/botlar";
  static const String previusAuthServicesLogin = "0";

  static const String authServicesLogin = "login";
  static const String users = "users";
  static const String requests = "requests";
  static const String register = "kayit-ol";
  static const String logout = "cikis-yap";
  static const String forgotPassword = "sifremi-unuttum";
  static const String mygroups = "gruplarim";
  static const String myschools = "okullarim";
  static const String mystations = "istasyonlarim";
  static const String profileposts = "sosyal/liste";
  static const String xpordering = "xpsiralama";
  static const String popordering = "popsiralama";
  static const String notifications = "bildirimler";
  static const String chat = "sohbet";
  static const String chatfriends = "sohbet/arkadaslarim";
  static const String chatdetail = "sohbetdetay";
  static const String chatsend = "sohbetgonder";

  static const String blockinglist = "engel";
  static const String bloclistadd = "engel/ekle";
  static const String bloclistremove = "engel/sil";
  static const String categories = "kategoriler";
  static const String categorydetail = "kategoriler-detay";
  static const String countries = "ulkeler";
  static const String provinces = "iller";
  static const String eventlist = "etkinlikler/liste";
  static const String eventdetail = "etkinlikler";
  static const String joinleave = "katilma";
  static const String participant = "katilim";

  static const String groups = "gruplar";
  static const String groupmembers = "gruplar/uyeler";
  static const String groupleave = "gruplar/ayril";
  static const String groupsettings = "gruplar/ayarlar";
  static const String groupInviteanswer = "gruplar-davetcevap";
  static const String groupInvite = "gruplar/davetet";
  static const String groupuserremove = "gruplar/gruptanat";
  static const String groupcreate = "gruplar-olustur";

  //JoinUs
  static const String permissions = "yetkiler";
  static const String applicationList = "ekibimiz/basvurular";
  static const String requestjoindepertment = "ekibimiz/katil-istek";

  //LoginRegister
  static const String invitecodefetch = "davetkodsorgula";

  //Media
  static const String media = "medya";
  static const String mediaturn = "medya/donder";
  static const String mediaupload = "medya/yukle";

  //News
  static const String newsList = "haberler/liste";
  static const String newsDetail = "haberler/detay";

  //Notification
  static const String notificationsettings = "bildirimler/ayarlar/liste";
  static const String notificationsettingsupdate = "bildirimler/ayarlar";

  //Posts
  static const String postaddlike = "sosyal/begeni-ekle";
  static const String postremovelike = "sosyal/begeni-sil";
  static const String commentaddlike = "sosyal/begeni-ekle";
  static const String commentunlike = "sosyal/begeni-sil";
  static const String postshare = "sosyal/olustur";
  static const String postremove = "sosyal/sil";
  static const String postremovecomment = "sosyal/yorum-sil";
  static const String getposts = "sosyal/liste";
  static const String getcomments = "sosyal/yorumlar";
  static const String createcomments = "sosyal/yorum-olustur";
  static const String postlikers = "sosyal/begenenler";
}
