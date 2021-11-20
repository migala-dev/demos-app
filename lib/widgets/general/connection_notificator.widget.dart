import 'package:flutter/material.dart';
import 'package:demos_app/widgets/snackbars/no_connection.snackbar.dart';
import 'package:demos_app/core/bloc/connection/connection_status_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectionNotificator extends StatelessWidget {
  const ConnectionNotificator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionStatusBloc, ConnectionStatusState>(
      builder: (context, state) {
        if (state == ConnectionStatusState.Unconnected)
          return NoConnectionSnackbar();

        return Container(height: 0);
      },
    );
  }
}
