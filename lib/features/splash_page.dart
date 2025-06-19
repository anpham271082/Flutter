import 'dart:async';
import 'package:flutter/material.dart';
import '../core/utils/navigators.dart';
import '../core/utils/devices.dart';
import '../core/utils/files.dart';
import 'base_page.dart';

class SplashPage extends BasePage {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage> {
  startTime() async => Timer(const Duration(seconds: 2), navigationPage);
  void navigationPage() {
    AppFiles.shared
      .readFileLanguage()
      .then((value) => Navigator.of(AppNavigator.navigationKey.currentContext!).pushReplacementNamed('/MyApp'));
  }
  @override
  void initState() {
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    AppDevices.shared.setDeviceSize(context);
    ///final favouriteViewModel =Provider.of<FavouriteViewModel>(context ,listen: false);
   // favouriteViewModel.fetchFavourites;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/logos/logo.jpg',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
