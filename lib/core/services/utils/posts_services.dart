part of 'package:armoyu_services/armoyu_services.dart';

class PostsServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  PostsServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  Future<PostLikeResponse> like({required int postID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "postID": "$postID",
        "kategori": "post",
      },
      endpoint: "0/0/${_EndpointConstants.postaddlike}/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    PostLikeResponse armoyuresponse = PostLikeResponse(result: result);
    if (response['durum'] == 0) {
      return armoyuresponse;
    }
    return armoyuresponse;
  }

  Future<PostUnLikeResponse> unlike({required int postID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "postID": "$postID",
        "kategori": "post",
      },
      endpoint: "0/0/${_EndpointConstants.postremovelike}/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    PostUnLikeResponse armoyuresponse = PostUnLikeResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }
    return armoyuresponse;
  }

  Future<PostCommentLikeResponse> commentlike({required int commentID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "postID": "$commentID",
        "kategori": "postyorum",
      },
      endpoint: "0/0/${_EndpointConstants.commentaddlike}/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    PostCommentLikeResponse armoyuresponse =
        PostCommentLikeResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }
    return armoyuresponse;
  }

  Future<PostCommentUnLikeResponse> commentunlike(
      {required int commentID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "postID": "$commentID",
        "kategori": "postyorum",
      },
      endpoint: "0/0/${_EndpointConstants.commentunlike}/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    PostCommentUnLikeResponse armoyuresponse =
        PostCommentUnLikeResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }
    return armoyuresponse;
  }

  Future<PostShareResponse> share({
    required String text,
    required List<XFile> files,
    required String? location,
  }) async {
    List<http.MultipartFile> photosCollection = [];

    for (XFile element in files) {
      photosCollection.add(
        await _apiHelpers.generateImageFile(
          "paylasimfoto[]",
          element,
        ),
      );
    }

    Map<String, String> formData;

    if (location != null) {
      formData = {
        "sosyalicerik": text,
        "konum": location,
      };
    } else {
      formData = {
        "sosyalicerik": text,
      };
    }
    Map<String, dynamic> response = await _apiHelpers.post(
      body: formData,
      files: photosCollection,
      endpoint: "0/0/${_EndpointConstants.postshare}/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    PostShareResponse armoyuresponse = PostShareResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }
    return armoyuresponse;
  }

  Future<PostRemoveResponse> remove({required int postID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"postID": "$postID"},
      endpoint: "0/0/${_EndpointConstants.postremove}/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    PostRemoveResponse armoyuresponse = PostRemoveResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }
    return armoyuresponse;
  }

  Future<PostRemoveCommentResponse> removecomment(
      {required int commentID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"yorumID": "$commentID"},
      endpoint: "0/0/${_EndpointConstants.postremovecomment}/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    PostRemoveCommentResponse armoyuresponse =
        PostRemoveCommentResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }
    return armoyuresponse;
  }

  Future<PostFetchListResponse> getPosts({required int page}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"limit": "20"},
      endpoint: "0/0/${_EndpointConstants.getposts}/$page/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    PostFetchListResponse armoyuresponse =
        PostFetchListResponse(result: result);
    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    List<APIPostList> postList = [];
    for (var element in response['icerik']) {
      List<APIPostLiker> postlikersList = [];
      for (var postliker in response['paylasimilkucbegenen']) {
        postlikersList.add(
          APIPostLiker(
            postlikeID: postliker['begeni_ID'],
            likerID: postliker['ID'],
            likerdisplayname: postliker['adsoyad'],
            likerusername: postliker['kullaniciadi'],
            likeravatar: MediaURL(
              bigURL: postliker['avatar'],
              normalURL: postliker['avatar'],
              minURL: postliker['avatar'],
            ),
            likerURL: postliker['URL'],
            likedate: postliker['begeni_zaman'],
          ),
        );
      }

      List<APIPostComments> postcommenterList = [];
      for (var postcommenter in response['ilkucyorum']) {
        postcommenterList.add(
          APIPostComments(
            postcommenter: PostCommenter(
              userID: postcommenter['yorumcuid'],
              mention: postcommenter['yorumcuetiketad'],
              username: postcommenter['yorumcukullaniciad'],
              displayname: postcommenter['yorumcuadsoyad'],
              userURL: postcommenter['oyunculink'],
              avatar: MediaURL(
                bigURL: postcommenter['yorumcuavatar'],
                normalURL: postcommenter['yorumcuufakavatar'],
                minURL: postcommenter['yorumcuminnakavatar'],
              ),
            ),
            commentContent: postcommenter['yorumcuicerik'],
            likeCount: postcommenter['yorumbegenisayi'],
            reportCount: postcommenter['yorumsikayetsayi'],
            isLikedByMe: postcommenter['benbegendim'],
            isReportedByMe: postcommenter['bensikayet'],
            commentID: postcommenter['yorumID'],
            commentElapsedTime: postcommenter['yorumcuzamangecen'],
            commentTime: postcommenter['yorumcuzaman'],
            postID: postcommenter['paylasimID'],
            replyTo: postcommenter['yorumcukimeyanit'],
          ),
        );
      }

      List<Media> mediaList = [];
      for (var media in response['paylasimfoto']) {
        mediaList.add(
          Media(
            mediaID: media['fotoID'],
            mediaURL: MediaURL(
              bigURL: media['fotourl'],
              normalURL: media['fotoufakurl'],
              minURL: media['fotominnakurl'],
            ),
            mediaDirection: media['medyayonu'],
          ),
        );
      }

      postList.add(
        APIPostList(
          postID: element['paylasimID'],
          posttype: element['paylasimturu'],
          postdevice: element['paylasimnereden'],
          postOwner: PostOwner(
            ownerID: element['sahipID'],
            displayName: element['sahipID'],
            ownerURL: element['sahipID'],
            avatar: MediaURL(
              bigURL: element['sahipavatar'],
              normalURL: element['sahipavatarufaklik'],
              minURL: element['sahipavatarminnak'],
            ),
            jobRole: element['sahipmeslekisyerirol'],
            job: element['sahipmeslekisyerirollink'],
          ),
          content: element['paylasimicerik'],
          location: element['paylasimkonum'],
          date: element['paylasimzaman'],
          datecounting: element['paylasimzamangecen'],
          editdate: element['paylasimzamanedit'],
          likeCount: element['begenisay'],
          commentCount: element['yorumsay'],
          repostCount: element['repostsay'],
          reportCount: element['sikayetsay'],
          didilikeit: element['benbegendim'],
          didicommentit: element['benyorumladim'],
          didirepostit: element['benretweetledim'],
          didireportit: element['bensikayet'],
          firstlikers: postlikersList,
          firstcomments: postcommenterList,
          media: mediaList,
        ),
      );
    }
    armoyuresponse.response = postList;

    return armoyuresponse;
  }

  Future<PostFetchResponse> detailfetch({
    int? postID,
    String? category,
    int? categoryDetail,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "postID": "$postID",
        "category": "$category",
        "categorydetail": "$categoryDetail",
      },
      endpoint: "0/0/${_EndpointConstants.getposts}/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    PostFetchResponse armoyuresponse = PostFetchResponse(result: result);
    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    APIPostList? postList;
    for (var element in response['icerik']) {
      List<APIPostLiker> postlikersList = [];
      for (var postliker in response['paylasimilkucbegenen']) {
        postlikersList.add(
          APIPostLiker(
            postlikeID: postliker['begeni_ID'],
            likerID: postliker['ID'],
            likerdisplayname: postliker['adsoyad'],
            likerusername: postliker['kullaniciadi'],
            likeravatar: MediaURL(
              bigURL: postliker['avatar'],
              normalURL: postliker['avatar'],
              minURL: postliker['avatar'],
            ),
            likerURL: postliker['URL'],
            likedate: postliker['begeni_zaman'],
          ),
        );
      }

      List<APIPostComments> postcommenterList = [];
      for (var postcommenter in response['ilkucyorum']) {
        postcommenterList.add(
          APIPostComments(
            postcommenter: PostCommenter(
              userID: postcommenter['yorumcuid'],
              mention: postcommenter['yorumcuetiketad'],
              username: postcommenter['yorumcukullaniciad'],
              displayname: postcommenter['yorumcuadsoyad'],
              userURL: postcommenter['oyunculink'],
              avatar: MediaURL(
                bigURL: postcommenter['yorumcuavatar'],
                normalURL: postcommenter['yorumcuufakavatar'],
                minURL: postcommenter['yorumcuminnakavatar'],
              ),
            ),
            commentContent: postcommenter['yorumcuicerik'],
            likeCount: postcommenter['yorumbegenisayi'],
            reportCount: postcommenter['yorumsikayetsayi'],
            isLikedByMe: postcommenter['benbegendim'],
            isReportedByMe: postcommenter['bensikayet'],
            commentID: postcommenter['yorumID'],
            commentElapsedTime: postcommenter['yorumcuzamangecen'],
            commentTime: postcommenter['yorumcuzaman'],
            postID: postcommenter['paylasimID'],
            replyTo: postcommenter['yorumcukimeyanit'],
          ),
        );
      }

      List<Media> mediaList = [];
      for (var media in response['paylasimfoto']) {
        mediaList.add(
          Media(
            mediaID: media['fotoID'],
            mediaURL: MediaURL(
              bigURL: media['fotourl'],
              normalURL: media['fotoufakurl'],
              minURL: media['fotominnakurl'],
            ),
            mediaDirection: media['medyayonu'],
          ),
        );
      }

      postList = APIPostList(
        postID: element['paylasimID'],
        posttype: element['paylasimturu'],
        postdevice: element['paylasimnereden'],
        postOwner: PostOwner(
          ownerID: element['sahipID'],
          displayName: element['sahipID'],
          ownerURL: element['sahipID'],
          avatar: MediaURL(
            bigURL: element['sahipavatar'],
            normalURL: element['sahipavatarufaklik'],
            minURL: element['sahipavatarminnak'],
          ),
          jobRole: element['sahipmeslekisyerirol'],
          job: element['sahipmeslekisyerirollink'],
        ),
        content: element['paylasimicerik'],
        location: element['paylasimkonum'],
        date: element['paylasimzaman'],
        datecounting: element['paylasimzamangecen'],
        editdate: element['paylasimzamanedit'],
        likeCount: element['begenisay'],
        commentCount: element['yorumsay'],
        repostCount: element['repostsay'],
        reportCount: element['sikayetsay'],
        didilikeit: element['benbegendim'],
        didicommentit: element['benyorumladim'],
        didirepostit: element['benretweetledim'],
        didireportit: element['bensikayet'],
        firstlikers: postlikersList,
        firstcomments: postcommenterList,
        media: mediaList,
      );
    }
    armoyuresponse.response = postList;
    return armoyuresponse;
  }

  Future<PostCommentsFetchResponse> commentsfetch({required int postID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"postID": "$postID"},
      endpoint: "0/0/${_EndpointConstants.getcomments}/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    PostCommentsFetchResponse armoyuresponse =
        PostCommentsFetchResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    List<APIPostComments> postcommentsList = [];
    for (var postcommenter in response['ilkucyorum']) {
      postcommentsList.add(
        APIPostComments(
          postcommenter: PostCommenter(
            userID: postcommenter['yorumcuid'],
            mention: postcommenter['yorumcuetiketad'],
            username: postcommenter['yorumcukullaniciad'],
            displayname: postcommenter['yorumcuadsoyad'],
            userURL: postcommenter['oyunculink'],
            avatar: MediaURL(
              bigURL: postcommenter['yorumcuavatar'],
              normalURL: postcommenter['yorumcuufakavatar'],
              minURL: postcommenter['yorumcuminnakavatar'],
            ),
          ),
          commentContent: postcommenter['yorumcuicerik'],
          likeCount: postcommenter['yorumbegenisayi'],
          reportCount: postcommenter['yorumsikayetsayi'],
          isLikedByMe: postcommenter['benbegendim'],
          isReportedByMe: postcommenter['bensikayet'],
          commentID: postcommenter['yorumID'],
          commentElapsedTime: postcommenter['yorumcuzamangecen'],
          commentTime: postcommenter['yorumcuzaman'],
          postID: postcommenter['paylasimID'],
          replyTo: postcommenter['yorumcukimeyanit'],
        ),
      );
    }

    armoyuresponse.response = postcommentsList;
    return armoyuresponse;
  }

  Future<PostCreateCommentResponse> createcomment({
    required int postID,
    required String text,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "postID": "$postID",
        "yorumicerik": text,
        "kategori": "sosyal",
      },
      endpoint: "0/0/${_EndpointConstants.createcomments}/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    PostCreateCommentResponse armoyuresponse =
        PostCreateCommentResponse(result: result);
    if (response['durum'] == 0) {
      return armoyuresponse;
    }
    return armoyuresponse;
  }

  Future<PostLikesListResponse> postlikeslist({required int postID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"postID": "$postID"},
      endpoint: "0/0/${_EndpointConstants.postlikers}/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );
    PostLikesListResponse armoyuresponse =
        PostLikesListResponse(result: result);
    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    List<APIPostLiker> commentsList = [];
    for (var element in response['icerik']) {
      commentsList.add(
        APIPostLiker(
          postlikeID: element['paylasimID'],
          likerID: element['paylasimID'],
          likerdisplayname: element['begenenadi'],
          likerusername: element['begenenkullaniciadi'],
          likeravatar: MediaURL(
            bigURL: element['begenenavatar'],
            normalURL: element['begenenavatar'],
            minURL: element['begenenavatar'],
          ),
          likerURL:
              "https://aramizdakioyuncu.com/oyuncular/${element['paylasbegenenkullaniciadimID']}",
          likedate: element['begenmezaman'],
        ),
      );
    }

    armoyuresponse.response = commentsList;
    return armoyuresponse;
  }
}
