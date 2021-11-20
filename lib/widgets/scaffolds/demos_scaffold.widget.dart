import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:demos_app/widgets/general/connection_notificator.widget.dart';

class DemosScaffold extends StatelessWidget {
  const DemosScaffold({
    Key? key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final Widget? drawer;
  final void Function(bool)? onDrawerChanged;
  final Widget? endDrawer;
  final void Function(bool)? onEndDrawerChanged;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Color? drawerScrimColor;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.appBar,
      body: this.body,
      floatingActionButton: this.floatingActionButton,
      floatingActionButtonLocation: this.floatingActionButtonLocation,
      floatingActionButtonAnimator: this.floatingActionButtonAnimator,
      persistentFooterButtons: this.persistentFooterButtons,
      drawer: this.drawer,
      onDrawerChanged: this.onDrawerChanged,
      endDrawer: this.endDrawer,
      onEndDrawerChanged: this.onEndDrawerChanged,
      bottomNavigationBar: this.bottomNavigationBar,
      backgroundColor: this.backgroundColor,
      resizeToAvoidBottomInset: this.resizeToAvoidBottomInset,
      primary: this.primary,
      drawerDragStartBehavior: this.drawerDragStartBehavior,
      extendBody: this.extendBody,
      extendBodyBehindAppBar: this.extendBodyBehindAppBar,
      drawerScrimColor: this.drawerScrimColor,
      drawerEdgeDragWidth: this.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: this.drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: this.endDrawerEnableOpenDragGesture,
      restorationId: this.restorationId,
      bottomSheet: ConnectionNotificator(),
    );
  }
}
