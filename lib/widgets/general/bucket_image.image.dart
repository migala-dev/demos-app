import 'package:cached_network_image/cached_network_image.dart';
import 'package:demos_app/core/services/bucket.service.dart';
import 'package:flutter/material.dart';

class BucketImage extends StatefulWidget {
  final String? imageKey;
  final double width;
  final double boderRadius;

  BucketImage(
      {Key? key,
      required this.imageKey,
      required this.width,
      this.boderRadius = 0})
      : super(key: key);

  @override
  _BucketImageState createState() => _BucketImageState();
}

class _BucketImageState extends State<BucketImage> {
  String? imageUrl;

  Future<void> initializeImageUrl() async {
    String imageUrl = await BucketService().getUrlFromKey(widget.imageKey);
    if (this.imageUrl != imageUrl) {
      setState(() {
        this.imageUrl = imageUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeImageUrl();
    if (imageUrl == null) {
      return Container(
        width: widget.width,
        height: widget.width,
      );
    }
    return CachedNetworkImage(
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
      imageUrl: imageUrl!,
      height: widget.width,
      width: widget.width,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.boderRadius),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
