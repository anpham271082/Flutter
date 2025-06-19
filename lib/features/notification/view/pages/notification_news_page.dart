import 'package:flutter/material.dart';
import 'package:my_app_flutter/features/base_page.dart';
import 'package:my_app_flutter/features/notification/view/widgets/notification_widget.dart';
import 'package:my_app_flutter/features/notification/viewmodel/notification_news_viewmodel.dart';
import 'package:provider/provider.dart';
class NotificationNewsPage extends BasePage {
  const NotificationNewsPage({super.key});
  @override
  State<NotificationNewsPage> createState() => _NotificationNewsPageState();
}

class _NotificationNewsPageState extends State<NotificationNewsPage>
    with AutomaticKeepAliveClientMixin<NotificationNewsPage> {
  @override
  bool get wantKeepAlive => true;
  late NotificationNewsViewModel notificationNewsViewModel;
  @override
  void initState() {
    notificationNewsViewModel = Provider.of<NotificationNewsViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notificationNewsViewModel.fetchNotificationNewsJson();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Consumer<NotificationNewsViewModel>(builder: (context, value, child){
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: value.notificationsNews.length,
                      itemBuilder: (context, index) {
                        return NotificationWidget(
                          desc: value.notificationsNews[index].desc,
                          imgUrl: value.notificationsNews[index].imgUrl,
                          label: value.notificationsNews[index].label,
                          date: value.notificationsNews[index].date,
                        );
                      }); 
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
