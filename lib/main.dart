import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/core/utils/navigators.dart';
import 'package:my_app_flutter/features/home/viewmodel/favourite_viewmodel.dart';
import 'package:my_app_flutter/features/home/viewmodel/food_viewmodel.dart';
import 'package:my_app_flutter/features/notification/viewmodel/notification_my_self_viewmodel.dart';
import 'package:my_app_flutter/features/notification/viewmodel/notification_news_viewmodel.dart';
import 'package:my_app_flutter/features/notification/viewmodel/notification_service_viewmodel.dart';
import 'package:provider/provider.dart';
import '../features/splash_page.dart';
import '../features/app.dart';
import 'firebase_options.dart';
import 'firebase_api.dart';
GlobalKey<MyAppState> myAppStateKey = GlobalKey();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await FirebaseApi().initNotifications();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FavouriteViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => FoodViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationMySelfViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationNewsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationServiceViewModel(),
        ),
      ],
      child: MaterialApp(
              //debugShowCheckedModeBanner: false,
              navigatorKey: AppNavigator.navigationKey,
              home: const SplashPage(),
              routes: <String, WidgetBuilder>{
                '/MyApp': (BuildContext context) => MyApp(key: myAppStateKey)
              },
            ),
      ),);
}
