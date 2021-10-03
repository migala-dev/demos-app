import 'package:flutter/material.dart';

class NoConnectionSnackbar extends StatelessWidget {
  const NoConnectionSnackbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.wifi),
          SizedBox(
            width: 5,
          ),
          Text('Sin conexión')
        ],
      ),
    );
  }
}
