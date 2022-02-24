import 'package:cached_network_image/cached_network_image.dart';
import 'package:demos_app/core/services/bucket.service.dart';
import 'package:flutter/material.dart';

class BucketImage extends StatelessWidget {
  final String? imageKey;
  final double width;
  final double boderRadius;

  const BucketImage(
      {Key? key,
      required this.imageKey,
      required this.width,
      this.boderRadius = 0})
      : super(key: key);

  Future<String> getImageUrl() async {
    String imageUrl = await BucketService().getUrlFromKey(imageKey);

    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getImageUrl(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return SizedBox(
            width: width,
            height: width,
          );
        }

        final String imageUrl = snapshot.data!;

        return CachedNetworkImage(
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageUrl: imageUrl,
          height: width,
          width: width,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(boderRadius),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
