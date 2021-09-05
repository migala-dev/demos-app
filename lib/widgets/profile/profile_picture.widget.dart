import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final VoidCallback? onPictureEditPress;
  final bool editable;
  final String? imageUrl;
  final double? width;
  final double? percentage;

  const ProfilePicture(
      {Key? key,
      this.editable = false,
      this.onPictureEditPress,
      this.imageUrl,
      this.width,
      this.percentage = 0.4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        getImage(size),
        Positioned(
            bottom: 0,
            right: 0,
            child: this.editable
                ? FloatingActionButton(
                    elevation: 0,
                    mini: true,
                    child: Icon(Icons.photo_camera),
                    onPressed: onPictureEditPress,
                  )
                : Container())
      ],
    );
  }

  Widget getImage(size) {
    double imageWidth = (width ?? size.width) * percentage;
    return imageUrl == null
        ? getDefaultImage(imageWidth)
        : getProfileImage(imageWidth);
  }

  Widget getDefaultImage(double width) {
    return Image(
        image: AssetImage('assets/images/default-profile.png'),
        width: width,
        height: width,
        fit: BoxFit.cover);
  }

  Widget getProfileImage(double width) {
    return CachedNetworkImage(
      placeholder: (context, url) => CircularProgressIndicator(),
      imageUrl: imageUrl!,
      height: width,
      width: width,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width / 2),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
