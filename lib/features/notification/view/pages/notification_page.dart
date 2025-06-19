import 'package:flutter/material.dart';
import 'package:my_app_flutter/core/common/styles/styles.dart';
import 'package:my_app_flutter/core/constants/colors.dart';
import 'package:my_app_flutter/core/utils/files.dart';
import 'package:my_app_flutter/features/base_page.dart';
import 'package:my_app_flutter/features/notification/view/pages/notification_my_self_page.dart';
import 'package:my_app_flutter/features/notification/view/pages/notification_news_page.dart';
import 'package:my_app_flutter/features/notification/view/pages/notification_service_page.dart';

class NotificationPage extends BasePage {
  const NotificationPage({super.key});
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  static final List<Widget> _widgetOptions = <Widget>[
    const NotificationServicePage(),
    const NotificationMySelfPage(),
    const NotificationNewsPage(),
  ];
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  TabBar getTabBar() {
    return TabBar(
      indicatorColor: AppColors.kTaskColor,
      labelColor: AppColors.kTaskColor,
      unselectedLabelColor: AppColors.colorTextInput,
      tabs: <Tab>[
        AppStyles.tabTitle(
            AppFiles.shared.language("services", "services")),
        AppStyles.tabTitle(
            AppFiles.shared.language("my self", "my self")),
        AppStyles.tabTitle(AppFiles.shared.language("news", "news")),
      ],
      controller: controller,
    );
  }

  TabBarView getTabBarView(var tabs) {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      children: tabs,
      controller: controller,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: AppBar(
            backgroundColor: AppColors.kWhiteColor,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            bottom: getTabBar(),
          )),
      body: getTabBarView(
          <Widget>[_widgetOptions[0], _widgetOptions[1], _widgetOptions[2]]),
    );
  }
}
