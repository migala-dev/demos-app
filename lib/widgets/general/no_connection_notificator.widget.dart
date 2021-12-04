import 'package:flutter/material.dart';
import 'package:demos_app/widgets/snackbars/no_connection.snackbar.dart';
import 'package:demos_app/core/bloc/connection/connection_status_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoConnectionNotificator extends StatelessWidget {
  const NoConnectionNotificator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionStatusBloc, ConnectionStatusState>(
      builder: (context, state) {
        if (state == ConnectionStatusState.unconnected) {
          return const NoConnectionSnackbar();
        }

        return Container(height: 0);
      },
    );
  }
}
