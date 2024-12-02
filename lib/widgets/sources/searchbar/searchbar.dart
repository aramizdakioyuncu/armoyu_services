import 'package:armoyu_services/armoyu_services.dart';
import 'package:armoyu_services/core/debouncer.dart';
import 'package:armoyu_services/core/models/ARMOYU/API/search/search_list.dart';
import 'package:armoyu_services/core/models/ARMOYU/_response/response.dart';
import 'package:armoyu_services/core/models/ARMOYU/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ARMOYUSearchBar {
  final ARMOYUServices service;

  ARMOYUSearchBar(this.service);
  final Debouncer debouncer =
      Debouncer(delay: const Duration(milliseconds: 500));

  Widget buildStatefulWidget({
    required RxList<User> allItems,
    required RxList<User> filteredItems,
    required SearchController searchController,
  }) {
    return MyStatefulWidget(
      allItems: allItems,
      searchController: searchController,
      service: service,
    );
  }

  Widget custom1({
    required RxList<User> allItems,
    required RxList<User> filteredItems,
    required SearchController searchController,
  }) {
    return SearchAnchor(
      searchController: searchController,
      viewHintText: 'Ara...',
      viewShape: const LinearBorder(),
      isFullScreen: false,
      viewConstraints: const BoxConstraints(maxHeight: 400),
      viewOnChanged: (value) {
        if (value.length < 4) {
          filteredItems.clear();
          return;
        }
        // Yerel filtreleme
        filteredItems.value = allItems
            .where((element) => element.displayname!
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
        filteredItems.refresh();

        debouncer(() async {
          if (value.length < 3) {
            filteredItems.clear();
            return;
          }

          // API'den veri çekme
          SearchListResponse response = await service.searchServices
              .searchengine(searchword: value, page: 1);

          if (response.result.status == false) {
            log(response.result.description);
            return;
          }

          // Yeni kullanıcıları ekleme
          for (APISearchDetail element in response.response!.search) {
            if (!allItems
                .any((filterelement) => filterelement.userID == element.id)) {
              allItems.add(
                User(
                  userID: element.id,
                  displayname: element.value,
                  avatar: element.avatar,
                ),
              );
            }
          }

          // Güncellenmiş filtreleme
          filteredItems.value = allItems
              .where((element) => element.displayname!
                  .toLowerCase()
                  .contains(value.toLowerCase()))
              .toList();

          filteredItems.refresh();
        });
      },
      builder: (context, controllerv2) {
        return SearchBar(
          controller: searchController,
          hintText: "Arama...",
          onChanged: (value) {
            controllerv2.openView();
          },
          onTap: () {
            controllerv2.openView();
          },
        );
      },
      suggestionsBuilder: (context, controllerv2) {
        return [
          Obx(
            () => SizedBox(
              child: Wrap(
                children: List.generate(
                  filteredItems.length.clamp(0, 10),
                  (index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        foregroundImage: CachedNetworkImageProvider(
                          filteredItems[index].avatar!,
                        ),
                      ),
                      title: Text(
                        filteredItems[index].displayname!,
                      ),
                      onTap: () {
                        searchController.text =
                            filteredItems[index].displayname!;
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ];
      },
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  final ARMOYUServices service;
  final List<User> allItems;

  final SearchController searchController;
  const MyStatefulWidget({
    super.key,
    required this.service,
    required this.allItems,
    required this.searchController,
  });

  @override
  MyStatefulWidgetState createState() => MyStatefulWidgetState();
}

class MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<User> filteredItems = [];
  late Debouncer debouncer;

  @override
  void initState() {
    super.initState();
    debouncer = Debouncer(delay: const Duration(milliseconds: 500));
    log("asd");
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: widget.searchController,
      viewHintText: 'Ara...',
      viewShape: const LinearBorder(),
      isFullScreen: false,
      viewConstraints: const BoxConstraints(maxHeight: 400),
      viewOnChanged: (value) {
        if (value.length < 4) {
          setState(() {
            filteredItems.clear();
          });
          return;
        }

        // Yerel filtreleme
        setState(() {
          filteredItems = widget.allItems
              .where((element) => element.displayname!
                  .toLowerCase()
                  .contains(value.toLowerCase()))
              .toList();
        });

        debouncer(() async {
          if (value.length < 3) {
            setState(() {
              filteredItems.clear();
            });
            return;
          }

          // API'den veri çekme
          SearchListResponse response = await widget.service.searchServices
              .searchengine(searchword: value, page: 1);

          if (response.result.status == false) {
            log(response.result.description);
            return;
          }

          // Yeni kullanıcıları ekleme
          for (APISearchDetail element in response.response!.search) {
            if (!widget.allItems
                .any((filterelement) => filterelement.userID == element.id)) {
              widget.allItems.add(
                User(
                  userID: element.id,
                  displayname: element.value,
                  avatar: element.avatar,
                ),
              );
            }
          }

          setState(() {
            // Güncellenmiş filtreleme
            filteredItems = widget.allItems
                .where((element) => element.displayname!
                    .toLowerCase()
                    .contains(value.toLowerCase()))
                .toList();
          });
        });
      },
      builder: (context, controllerv2) {
        return SearchBar(
          controller: widget.searchController,
          hintText: "Arama...",
          onChanged: (value) {
            controllerv2.openView();
          },
          onTap: () {
            controllerv2.openView();
          },
        );
      },
      suggestionsBuilder: (context, controllerv2) {
        return [
          SizedBox(
            child: Wrap(
              children: List.generate(
                filteredItems.length.clamp(0, 10),
                (index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      foregroundImage: CachedNetworkImageProvider(
                        filteredItems[index].avatar!,
                      ),
                    ),
                    title: Text(
                      filteredItems[index].displayname!,
                    ),
                    onTap: () {
                      widget.searchController.text =
                          filteredItems[index].displayname!;
                    },
                  );
                },
              ),
            ),
          ),
        ];
      },
    );
  }
}
