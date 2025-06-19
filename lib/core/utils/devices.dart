import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppDevices {
  static final AppDevices _singleton = AppDevices._internal();
  factory AppDevices() => _singleton;
  AppDevices._internal();
  static AppDevices get shared => _singleton;
  late double width;
  late double height;
  late double ratio;
  late double devicePixelRatio;
  late double topBarHeight;
  late double bottomBarHeight;
  static final navigatorKey = GlobalKey<NavigatorState>();

  void setDeviceSize(BuildContext context) {
    AppDevices.shared.width = MediaQuery.of(context).size.width;
    AppDevices.shared.height = MediaQuery.of(context).size.height;
    AppDevices.shared.ratio = MediaQuery.of(context).size.width / 320;
    AppDevices.shared.devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    AppDevices.shared.topBarHeight = MediaQuery.of(context).padding.top == 0
        ? 50
        : MediaQuery.of(context).padding.top;
    AppDevices.shared.bottomBarHeight = MediaQuery.of(context).padding.bottom;
  }
  static void hideKeyboard (BuildContext context) {
    FocusScope.of (context).requestFocus (FocusNode());
  }

  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle (statusBarColor: color),
    );
  }
  static bool isLandscapeOrientation(BuildContext context) { 
    final viewInsets = View. of (context).viewInsets;
    return viewInsets.bottom == 0;
  }
  static bool isPortraitOrientation (BuildContext context) {
    final viewInsets = View.of (context).viewInsets;
    return viewInsets.bottom != 0;
  }
  static void setFullscreen (bool enable) {
    SystemChrome.setEnabledSystemUIMode (enable? SystemUiMode.immersiveSticky: SystemUiMode.edgeToEdge);
  }
  static double getKeyboardHeight(BuildContext context) {
    final viewInsets = MediaQuery.of (context).viewInsets; 
    return viewInsets.bottom;
  }
  static Future<bool> isKeyboardVisible() async {
    final viewInsets = View. of (navigatorKey.currentContext!).viewInsets; 
    return viewInsets.bottom > 0;
  }
  static Future<bool> isPhysicalDevice() async {
    return defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS;
  }
  static void vibrate (Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }
  static Future<void> setPreferredOrientations (List<DeviceOrientation> orientations) async { 
    await SystemChrome.setPreferredOrientations(orientations);
  }
  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: []);
  }
  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com'); 
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
  static bool isIOS() {
    return Platform.isIOS;
  }
  static bool isAndroid() {
    return Platform.isAndroid;
  }
}