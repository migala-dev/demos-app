import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demos_app/core/bloc/connection/connection_status_bloc.dart';
import 'package:demos_app/widgets/snackbars/no_connection.snackbar.dart';

class SafeConnection extends StatelessWidget {
  final Widget child;

  const SafeConnection({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionStatusBloc, ConnectionStatusState>(
      builder: (context, state) {
        if (state == ConnectionStatusState.Connected) {
          return child;
        }

        return Column(
          children: [
            NoConnectionSnackbar(),
            Expanded(child: child),
          ],
        );
      },
    );
  }
}
