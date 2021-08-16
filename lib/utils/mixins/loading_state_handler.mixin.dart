import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

mixin LoadingStateHandler<T extends StatefulWidget> on State<T> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void wrapLoadingTransaction(AsyncCallback method) async {
    if (!isLoading) {
      setIsLoadingState(true);
      try {
        await method();
      } catch (err) {
        print(err);
      } finally {
        setIsLoadingState(false);
      }
    }
  }

  void setIsLoadingState(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }
}
