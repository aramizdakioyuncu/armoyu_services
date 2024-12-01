import 'package:armoyu_services/core/models/ARMOYU/media.dart';

class Group {
  final int groupID;
  final String name;
  final String shortname;
  final String registerdate;
  final int membercount;
  final String? category;
  final String? categorydetail;

  final String? defaultgame;

  final bool joinable;
  final String? description;
  final GroupSocial socail;
  final String groupURL;
  final GroupOwner groupOwner;
  final Media logo;
  final Media banner;

  Group({
    required this.groupID,
    required this.name,
    required this.shortname,
    required this.registerdate,
    required this.membercount,
    required this.category,
    required this.categorydetail,
    required this.defaultgame,
    required this.joinable,
    this.description,
    required this.socail,
    required this.groupURL,
    required this.groupOwner,
    required this.logo,
    required this.banner,
  });

  Map<String, dynamic> toJson() {
    return {
      'groupID': groupID,
      'name': name,
      'shortname': shortname,
      'registerdate': registerdate,
      'membercount': membercount,
      'category': category,
      'categorydetail': categorydetail,
      'defaultgame': defaultgame,
      'joinable': joinable,
      'description': description,
      'socail': socail.toJson(),
      'groupURL': groupURL,
      'groupOwner': groupOwner.toJson(),
      'logo': logo.toJson(),
      'banner': banner.toJson(),
    };
  }

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      groupID: json['groupID'],
      name: json['name'],
      shortname: json['shortname'],
      registerdate: json['registerdate'],
      membercount: json['membercount'],
      category: json['category'],
      categorydetail: json['categorydetail'],
      defaultgame: json['defaultgame'],
      joinable: (json['joinable']),
      description: json['description'],
      socail: GroupSocial.fromJson(json['socail']),
      groupURL: json['groupURL'],
      groupOwner: GroupOwner.fromJson(json['groupOwner']),
      logo: Media.fromJson(json['logo']),
      banner: Media.fromJson(json['banner']),
    );
  }
}

class GroupSocial {
  String? website;
  String? discord;

  GroupSocial({
    this.website,
    this.discord,
  });

  Map<String, dynamic> toJson() {
    return {
      'website': website,
      'discord': discord,
    };
  }

  factory GroupSocial.fromJson(Map<String, dynamic> json) {
    return GroupSocial(
      website: json['website'],
      discord: json['discord'],
    );
  }
}

class GroupOwner {
  int userID;
  String displayname;
  String username;
  MediaURL avatar;
  GroupOwner({
    required this.userID,
    required this.displayname,
    required this.username,
    required this.avatar,
  });

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'displayname': displayname,
      'username': username,
      'avatar': avatar,
    };
  }

  factory GroupOwner.fromJson(Map<String, dynamic> json) {
    return GroupOwner(
      userID: json['userID'],
      displayname: json['displayname'],
      username: json['username'],
      avatar: MediaURL.fromJson(json['avatar']),
    );
  }
}
