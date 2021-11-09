import 'package:demos_app/core/connection/app_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demos_app/core/bloc/connection/connection_status_bloc.dart';
import 'package:demos_app/widgets/snackbars/no_connection.snackbar.dart';

class TopSnakbarsNotification extends StatelessWidget {
  final Widget child;

  const TopSnakbarsNotification({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appConnection = AppConnection();

    return BlocBuilder<ConnectionStatusBloc, ConnectionStatusState>(
      builder: (context, state) {
        if (state == ConnectionStatusState.Connected) {
          appConnection.connectApp();
          return child;
        } else if (state == ConnectionStatusState.Unconnected) {
          appConnection.disconnectApp();

          return Column(
            children: [
              NoConnectionSnackbar(),
              Expanded(child: child),
            ],
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
