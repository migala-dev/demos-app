import 'package:flutter/material.dart';

class SpacePicture extends StatelessWidget {
  const SpacePicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20.0)),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.camera_alt),
            mini: true,
          ),
        )
      ],
    );
  }
}
