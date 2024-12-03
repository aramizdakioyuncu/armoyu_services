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

  Future<NewsListResponse> fetch({required int page}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "sayfa": page,
        "limit": "10",
      },
      endpoint: "0/0/${_EndpointConstants.newsList}/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    NewsListResponse armoyuresponse = NewsListResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    List<APINewsDetail> list = [];

    for (var element in response['icerik']) {
      list.add(
        APINewsDetail(
          newsID: element['haberID'],
          newsURL: element['link'],
          newsOwner: UserInfo(
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

    armoyuresponse.response = APINewsList(news: list);
    return armoyuresponse;
  }

  Future<ServiceResult> fetchnews({required int newsID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"haberID": "$newsID"},
      endpoint: "0/0/${_EndpointConstants.newsDetail}/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    if (response['durum'] == 0) {
      return result;
    }

    return result;
  }
}
