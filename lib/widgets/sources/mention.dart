import 'dart:async';

import 'package:armoyu_services/armoyu_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';

class ARMOYUMention {
  final ARMOYUServices service;

  ARMOYUMention(this.service);

  // List<Map<String, dynamic>> peopleList = [];
  // List<Map<String, dynamic>> hashtagList = [];

  // void addpeopleList(Map<String, dynamic> newPerson) {
  //   // Eklemeden önce listede aynı kişinin olup olmadığını kontrol et
  //   // Eğer kişi listede yoksa ekle
  //   if (!peopleList.any((person) => person['id'] == newPerson['id'])) {
  //     peopleList.add(newPerson);
  //   } else {
  //     log("Kişi zaten listede bulunmaktadır.");
  //   }
  // }

  // void addhashtagList(Map<String, dynamic> newHashtag) {
  //   // Eklemeden önce listede aynı kişinin olup olmadığını kontrol et
  //   // Eğer hashtag listede yoksa ekle
  //   if (!hashtagList.any((hashtag) => hashtag['id'] == newHashtag['id'])) {
  //     hashtagList.add(newHashtag);
  //   } else {
  //     log("Hashtag zaten listede bulunmaktadır.");
  //   }
  // }

  FlutterMentions mentionTextFiled({
    required GlobalKey<FlutterMentionsState> key,
    required double height,
    required String hinttext,
    required Function(String val)? onChanged,
    Color? suggestionlistColor,
    int? minLines = 1,
    // required User currentUser,
    Timer? searchTimer,
  }) {
    return FlutterMentions(
      key: key,
      suggestionPosition: SuggestionPosition.Top,
      maxLines: 20,
      minLines: minLines,
      // suggestionListDecoration: BoxDecoration(color: Get.theme.cardColor),
      suggestionListDecoration: BoxDecoration(color: suggestionlistColor),
      // suggestionListHeight: Get.height / 3,
      suggestionListHeight: height,
      onChanged: (value) {
        List<String> words = value.split(' ');
        final String lastWord = words.isNotEmpty ? words.last : "";

        if (lastWord.isEmpty) {
          // Eğer son kelime boşsa, mevcut sorguyu iptal eder
          searchTimer?.cancel();
          return;
        }

        //Oyuncu listesi bomboşsa
        if (service.peopleList.isEmpty) {
          searchTimer = Timer(const Duration(milliseconds: 500), () async {
            Map<String, dynamic> response =
                await service.searchServices.onlyusers(searchword: "", page: 1);

            // SearchAPI f = SearchAPI(currentUser: currentUser);
            // Map<String, dynamic> response =
            //     await f.onlyusers(searchword: "", page: 1);
            if (response["durum"] == 0) {
              log(response["aciklama"]);
              return;
            }
            for (var element in response["icerik"]) {
              service.addpeopleList({
                'id': element["ID"].toString(),
                'display': element["username"].toString(),
                'full_name': element["Value"].toString(),
                'photo': element["avatar"].toString()
              });
            }
            // key.refresh();
          });
        }
        //Hashtag listesi bomboşsa
        if (service.hashtagList.isEmpty) {
          searchTimer = Timer(const Duration(milliseconds: 500), () async {
            // SearchAPI f = SearchAPI(currentUser: currentUser);
            // Map<String, dynamic> response =
            //     await f.hashtag(hashtag: "", page: 1);

            Map<String, dynamic> response =
                await service.searchServices.hashtag(hashtag: "", page: 1);

            if (response["durum"] == 0) {
              log(response["aciklama"]);
              return;
            }
            for (var element in response["icerik"]) {
              service.addhashtagList({
                'id': element["hashtag_ID"].toString(),
                'display': element["hashtag_value"].toString(),
                'numberofuses': element["hashtag_numberofuses"],
              });
            }
            // key.refresh();
          });
        }

        if (lastWord.length <= 3) {
          return;
        }

        if (lastWord[0] != "@" && lastWord[0] != "#") {
          // Eğer son kelime @ veya # ile başlamıyorsa, mevcut sorguyu iptal eder
          searchTimer?.cancel();
          return;
        }

        // Eğer buraya kadar gelindi ise, yeni bir kelime girilmiştir, mevcut sorguyu iptal eder
        searchTimer?.cancel();
        searchTimer = Timer(const Duration(milliseconds: 500), () async {
          // SearchAPI f = SearchAPI(currentUser: currentUser);

          Map<String, dynamic> response;
          if (lastWord[0] == "@") {
            // response = await f.onlyusers(searchword: lastWord.substring(1), page: 1);

            response = await service.searchServices
                .onlyusers(searchword: lastWord.substring(1), page: 1);
          } else if (lastWord[0] == "#") {
            // response = await f.hashtag(hashtag: lastWord.substring(1), page: 1);

            response = await service.searchServices
                .hashtag(hashtag: lastWord.substring(1), page: 1);
          } else {
            return;
          }

          if (response["durum"] == 0) {
            log(response["aciklama"]);
            return;
          }
          for (var element in response["icerik"]) {
            if (lastWord[0] == "@") {
              service.addpeopleList({
                'id': element["ID"].toString(),
                'display': element["username"].toString(),
                'full_name': element["Value"].toString(),
                'photo': element["avatar"].toString()
              });
            }
            if (lastWord[0] == "#") {
              service.addhashtagList({
                'id': element["hashtag_ID"].toString(),
                'display': element["hashtag_value"].toString(),
                'numberofuses': element["hashtag_numberofuses"],
              });
            }
          }

          // key.refresh();
        });
      },
      // decoration: InputDecoration(hintText: SocialKeys.socialwritesomething.tr),
      decoration: InputDecoration(hintText: hinttext),
      mentions: [
        poplementions(peopleList: service.peopleList),
        hashtag(hashtagList: service.hashtagList),
      ],
    );
  }

  Mention poplementions(
      {required List<Map<String, dynamic>> peopleList, Color? textcolor}) {
    return Mention(
      trigger: '@',
      style: const TextStyle(color: Colors.amber),
      data: peopleList,
      matchAll: false,
      suggestionBuilder: (data) {
        return Material(
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            enableFeedback: true,
            leading: CircleAvatar(
              foregroundImage: CachedNetworkImageProvider(data['photo']),
            ),
            title: Text(data['full_name']),
            subtitle: Text(
              "@${data['display']}",
              style: TextStyle(
                // color: Get.theme.primaryColor.withOpacity(0.7),
                color: textcolor,
              ),
            ),
          ),
        );
      },
    );
  }

  Mention hashtag(
      {required List<Map<String, dynamic>> hashtagList, Color? textcolor}) {
    return Mention(
      trigger: '#',
      style: const TextStyle(color: Colors.blue),
      data: hashtagList,
      matchAll: false,
      suggestionBuilder: (data) {
        return ListTile(
          title: Text("#${data['display']} (${data["numberofuses"]})"),
          subtitle: Text(
            "Gündemdekiler",
            style: TextStyle(
              color: textcolor,
              // color: Get.theme.primaryColor.withOpacity(0.7),
            ),
          ),
        );
      },
    );
  }
}
