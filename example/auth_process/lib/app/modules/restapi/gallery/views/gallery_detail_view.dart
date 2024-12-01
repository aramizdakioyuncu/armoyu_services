import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GalleryDetailView extends StatelessWidget {
  const GalleryDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        children: [
          ...List.generate(
            10,
            (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  width: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        "https://aramizdakioyuncu.com/galeri/images/1minnak31678774004.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
