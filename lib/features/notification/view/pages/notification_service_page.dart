import 'package:flutter/material.dart';
import 'package:my_app_flutter/features/base_page.dart';
import 'package:my_app_flutter/features/notification/view/widgets/notification_widget.dart';
import 'package:my_app_flutter/features/notification/viewmodel/notification_service_viewmodel.dart';
import 'package:provider/provider.dart';
class NotificationServicePage extends BasePage {
  const NotificationServicePage({super.key});
  @override
  State<NotificationServicePage> createState() =>
      _NotificationServicePageState();
}

class _NotificationServicePageState extends State<NotificationServicePage>
    with AutomaticKeepAliveClientMixin<NotificationServicePage> {
  @override
  bool get wantKeepAlive => true;
 late NotificationServiceViewModel notificationServiceViewModel;
  @override
  void initState() {
    notificationServiceViewModel = Provider.of<NotificationServiceViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notificationServiceViewModel.fetchNotificationServiceJson();
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
                  Consumer<NotificationServiceViewModel>(builder: (context, value, child){
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: value.notificationsService.length,
                      itemBuilder: (context, index) {
                        return NotificationWidget(
                          desc: value.notificationsService[index].desc,
                          imgUrl: value.notificationsService[index].imgUrl,
                          label: value.notificationsService[index].label,
                          date: value.notificationsService[index].date,
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
