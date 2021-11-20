import 'package:flutter/material.dart';

class NoConnectionSnackbar extends StatelessWidget {
  const NoConnectionSnackbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      width: double.infinity,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off),
          SizedBox(
            width: 5,
          ),
          Text('Sin conexión')
        ],
      ),
    );
  }
}
