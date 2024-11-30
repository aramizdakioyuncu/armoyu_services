import 'package:armoyu_services/core/models/ARMOYU/media.dart';

class News {
  final int newsID;
  final String newsURL;
  final NewsOwner newsOwner;
  final String title;
  final String? content;
  final String summary;
  final Media media;
  final String date;
  final String category;
  final int views;

  News({
    required this.newsID,
    required this.newsURL,
    required this.newsOwner,
    required this.title,
    this.content,
    required this.summary,
    required this.media,
    required this.date,
    required this.category,
    required this.views,
  });

  Map<String, dynamic> toJson() {
    return {
      'newsID': newsID,
      'newsURL': newsURL,
      'newsOwner': newsOwner.toJson(),
      'title': title,
      'content': content,
      'summary': summary,
      'media': media.toJson(),
      'date': date,
      'category': category,
      'views': views,
    };
  }

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      newsID: json['newsID'],
      newsURL: json['newsURL'],
      newsOwner: NewsOwner.fromJson(json['newsOwner']),
      title: json['title'],
      content: json['content'],
      summary: json['summary'],
      media: Media.fromJson(json['media']),
      date: json['date'],
      category: json['category'],
      views: json['views'],
    );
  }
}

class NewsOwner {
  int userID;
  String displayname;
  MediaURL avatar;
  NewsOwner({
    required this.userID,
    required this.displayname,
    required this.avatar,
  });

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'displayname': displayname,
      'avatar': avatar,
    };
  }

  factory NewsOwner.fromJson(Map<String, dynamic> json) {
    return NewsOwner(
      userID: json['userID'],
      displayname: json['displayname'],
      avatar: MediaURL.fromJson(json['avatar']),
    );
  }
}
