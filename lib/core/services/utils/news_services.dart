part of 'package:armoyu_services/armoyu_services.dart';

class NewsServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  NewsServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  Future<List<News>> fetch({
    required String? username,
    required String? password,
    required int page,
  }) async {
    if (password != null) {
      password = _apiHelpers.generateMd5(password);
    }

    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "sayfa": page,
        "limit": "10",
      },
      endpoint:
          "${username ?? "0"}/${password ?? "0"}/${_EndpointConstants.newsList}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );

    List<News> list = [];

    if (response['durum'] == 0) {
      return list;
    }

    for (var element in response['icerik']) {
      list.add(
        News(
          newsID: element['haberID'],
          newsURL: element['link'],
          newsOwner: NewsOwner(
            userID: element['yazarID'],
            displayname: element['yazar'],
            avatar: MediaURL(
              bigURL: element['yazaravatar'],
              normalURL: element['yazaravatar'],
              minURL: element['yazaravatar'],
            ),
          ),
          title: element['haberbaslik'],
          content: null,
          summary: element['ozet'],
          media: Media(
            mediaID: 0,
            mediaURL: MediaURL(
              bigURL: element['resim'],
              normalURL: element['resimorijinal'],
              minURL: element['resimminnak'],
            ),
          ),
          date: element['gecenzaman'],
          category: element['kategori'],
          views: element['goruntulen'],
        ),
      );
    }

    return list;
  }

  Future<Map<String, dynamic>> fetchnews({
    required String username,
    required String password,
    required int newsID,
  }) async {
    password = _apiHelpers.generateMd5(password);

    return await _apiHelpers.post(
      body: {
        "haberID": "$newsID",
      },
      endpoint: "$username/$password/${_EndpointConstants.newsDetail}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }
}
