import 'dart:async';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});
  @override
  State<StatefulWidget> createState() => BaseState();
}
class BaseState<T extends BasePage> extends State<T>
    with WidgetsBindingObserver {
  bool canTouchToHideKeyboard = false;
  bool isFirstTimeInit = true;
  bool canTriggerOnBack = false;
  void onResume() {}
  void needHideKeyboard() {
    canTouchToHideKeyboard = true;
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResume();
        debugPrint("onResume");
        break;
      case AppLifecycleState.inactive:
        debugPrint("inactive");
        break;
      case AppLifecycleState.detached:
        debugPrint("detached");
        break;
      case AppLifecycleState.paused:
        debugPrint("detached");
        break;
      default:
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  Future<bool> onBackPress() {
    return Future(() => true);
  }
  Widget makeParent(Widget widget) {
    return GestureDetector(
            child: /*WillPopScope(
              onWillPop: () {
                return onBackPress();
              },
              child: widget,
            ),*/
            PopScope(
              canPop: false, // prevent back
              onPopInvokedWithResult: (bool didPop, Object? result)  async {
                onBackPress();
              },
              child: widget,
            ),
            onTap: () {
              if (canTouchToHideKeyboard) {
                FocusScope.of(context).requestFocus(FocusNode());
              }
            });
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isFirstTimeInit) {
        isFirstTimeInit = false;
        onStart();
        onResume();
      } else {
        onResume();
      }
    });
  }
  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint("implement didUpdateWidget");
  }
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
  void hideKeyboard() {}
  void notifyError(String error) {
    debugPrint("notifyError");
  }
  void onStart() {
    canTriggerOnBack = true;
  }
}
