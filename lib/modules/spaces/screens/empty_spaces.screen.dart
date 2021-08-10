import 'package:flutter/material.dart';

class EmptySpacesHomeScreen extends StatelessWidget {
  const EmptySpacesHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Espacios'),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No tienes espacios por el momento',
                    style: TextStyle(color: Colors.grey)),
                SizedBox(
                  height: 10,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: double.infinity),
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Crea tu primer espacio',
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
