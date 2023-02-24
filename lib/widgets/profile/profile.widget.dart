/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:camera/camera.dart';
import 'package:demos_app/config/themes/main_theme.dart';
import 'package:demos_app/core/services/current_user/current_user.service.dart';
import 'package:demos_app/shared/screens/camera_preview.screen.dart';
import 'package:demos_app/widgets/general/card.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demos_app/core/bloc/current_user_bloc/current_user_bloc.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/widgets/pages/image_editor.page.dart';
import 'package:demos_app/widgets/profile/profile_form.widget.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';

class Profile extends StatelessWidget {
  final List<Widget>? children;
  const Profile({Key? key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: BlocBuilder<CurrentUserBloc, User?>(
              bloc: CurrentUserBloc(),
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ProfilePicture(
                        imageKey: state?.profilePictureKey,
                        onPictureEditPress: () => onPictureEditPress(context),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 44.0, bottom: 16.0),
                        child: CardWidget(
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 28.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 40.0),
                                Text(
                                  'Perfil',
                                  style: TextStyle(
                                      fontSize: 26.0,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 40.0),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ProfileForm(
                                        onEditNamePress: (String? name) {
                                          updateName(name);
                                        },
                                        user: state,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Column(children: children ?? []),
        ],
      ),
    );
  }

  void updateName(String? name) async {
    if (name == null && name == '') return;

    final user = await CurrentUserService().updateUserName(name);
    CurrentUserBloc().add(CurrentUserUpdated(user));
  }

  void onPictureEditPress(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 120,
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Agregar desde...'),
              const SizedBox(height: 16),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.folder, size: 30, color: primaryColor),
                    SizedBox(width: 16),
                    Text('Archivos')
                  ],
                ),
                onTap: () => onOpenFilesPress(context),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: const [
                    Icon(Icons.camera_alt, size: 30, color: primaryColor),
                    SizedBox(width: 16),
                    Text('Camara')
                  ],
                ),
                onTap: () => onOpenCameraPress(context),
              )
            ],
          ),
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  void onOpenCameraPress(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();

    await availableCameras().then((value) async {
      final photo = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => CameraPreviewScreen(cameras: value)));

      if (photo != null) {
        final user = await CurrentUserService().uploadProfileImage(photo);
        CurrentUserBloc().add(CurrentUserUpdated(user));
      }
    });
  }

  void onOpenFilesPress(BuildContext context) async {
    final image = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ImageEditorPage()));

    if (image != null) {
      final user = await CurrentUserService().uploadProfileImage(image);
      CurrentUserBloc().add(CurrentUserUpdated(user));
    }
  }
}
