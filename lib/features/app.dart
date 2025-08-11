import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_flutter/core/utils/files.dart';
import 'package:my_app_flutter/features/menu/drawer_menu.dart';
import 'package:my_app_flutter/features/electronics/bloc/electronics_bloc.dart';
import 'package:my_app_flutter/features/electronics/view/pages/electronics_page.dart';
import 'package:my_app_flutter/features/menu/menu_item.dart';
import 'package:my_app_flutter/features/notification/view/pages/notification_page.dart';
import 'package:my_app_flutter/features/examples/example_pages.dart';
import 'package:my_app_flutter/features/slide_image/slide_image_page.dart';
import '../core/constants/themes.dart';
import 'package:my_app_flutter/features/home/view/pages/home_page.dart';
import '../core/constants/colors.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}
class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }
  int _selectedIndex = 0;
  static final List<Widget> _listPages = <Widget>[
    const HomePage(),
    const ElectronicsPage(),
    const NotificationPage(),
    const SlideImagePage(),
    const ExamplePages(),
  ];
  static GlobalKey bottomNavigationBarKey = GlobalKey();
  final GlobalKey<MyAppState> keyMyAppState = GlobalKey<MyAppState>();


  final List<MenuItem> menuItems = [
    MenuItem('Dashboard', Icons.dashboard),
    MenuItem('Profile', Icons.person),
    MenuItem('Messages', Icons.message),
    MenuItem('Settings', Icons.settings),
    MenuItem('Logout', Icons.logout),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'my_app_flutter',
      color: AppColors.kTaskColor,
      theme: lightMode,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ElectronicsBloc(),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
        title: Text("my_app_flutter"),
      ),
          drawer: DrawerMenu(menuItems: menuItems),
          body: _listPages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            key: bottomNavigationBarKey,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.kTaskColor,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: AppFiles.shared.language("MVVM", "MVVM"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: AppFiles.shared.language("Multi Bloc", "Multi Bloc"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: AppFiles.shared.language("Notification", "Notification"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: AppFiles.shared.language("Slide Image", "Slide Image"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: AppFiles.shared.language("Samples", "Samples"),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black54,
            onTap: onItemTapped,
          ),
        ),
      )
    );
  }
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
