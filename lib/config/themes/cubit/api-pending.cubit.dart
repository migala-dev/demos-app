import 'dart:async';

import 'package:bloc/bloc.dart';

class ApiTimestamp {
  final DateTime timestamp = DateTime.now();
}

class ApiPendingCubit extends Cubit<bool> {
  static final ApiPendingCubit _apiPendingCubit = ApiPendingCubit._internal();
  final Duration intervalDuration = const Duration(seconds: 1);
  List<ApiTimestamp> timestampList = [];

  ApiPendingCubit._internal() : super(false) {
    Timer.periodic(intervalDuration, (timer) {
      checkTimestamps();
    });
  }
  
  factory ApiPendingCubit() {
    return _apiPendingCubit;
  }

  void addApiTimestamp(ApiTimestamp apiTimestamp) {
    timestampList.add(apiTimestamp);
  }

  void removeApiTimestamp(ApiTimestamp apiTimestamp) {
    timestampList.removeWhere((t) => t == apiTimestamp);
  }

  void checkTimestamps() {
    DateTime now = DateTime.now();
    if (timestampList.isEmpty && state == true) {
      emit(false);
    } else if (timestampList.where((t) => now.difference(t.timestamp).inSeconds > 1).isNotEmpty && state == false) {
      emit(true);
    }
  }
}
