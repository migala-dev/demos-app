import 'package:flutter/material.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/pages/spaces/widgets/popup_spaces_menu_options.widget.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';

class EmptySpacesScreen extends StatelessWidget {
  const EmptySpacesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Demos'),
          actions: [PopupSpacesMenuOptions()],
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: size.height * 0.2, right: 20.0, left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 28.0),
                  child: Icon(
                    Icons.category,
                    color: Colors.grey,
                    size: size.width * 0.35,
                  ),
                ),
                Text('No tienes espacios por el momento',
                    style: TextStyle(color: Colors.grey, fontSize: 16.0)),
                SizedBox(
                  height: 10,
                ),
                SafeWidgetValidator(
                    child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: double.infinity),
                  child: ElevatedButton(
                      onPressed: () {
                        goToCreateNewSpace(context);
                      },
                      child: Text(
                        'Crea tu primer espacio',
                      )),
                ))
              ],
            ),
          ),
        ));
  }

  void goToCreateNewSpace(BuildContext context) {
    Navigator.pushNamed(context, Routes.newSpace);
  }
}
