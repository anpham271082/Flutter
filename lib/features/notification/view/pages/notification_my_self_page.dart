import 'package:flutter/material.dart';
import 'package:my_app_flutter/features/base_page.dart';
import 'package:my_app_flutter/features/notification/view/widgets/notification_widget.dart';
import 'package:my_app_flutter/features/notification/viewmodel/notification_my_self_viewmodel.dart';
import 'package:provider/provider.dart';
class NotificationMySelfPage extends BasePage {
  const NotificationMySelfPage({super.key});
  @override
  State<NotificationMySelfPage> createState() => _NotificationMySelfPageState();
}
class _NotificationMySelfPageState extends State<NotificationMySelfPage>
    with AutomaticKeepAliveClientMixin<NotificationMySelfPage> {
  @override
  bool get wantKeepAlive => true;
  late NotificationMySelfViewModel notificationMySelfViewModel;
  @override
  void initState() {
    notificationMySelfViewModel = Provider.of<NotificationMySelfViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notificationMySelfViewModel.fetchNotificationMySelfJson();
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
                  Consumer<NotificationMySelfViewModel>(builder: (context, value, child){
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: value.notificationsMySelf.length,
                      itemBuilder: (context, index) {
                        return NotificationWidget(
                          desc: value.notificationsMySelf[index].desc,
                          imgUrl: value.notificationsMySelf[index].imgUrl,
                          label: value.notificationsMySelf[index].label,
                          date: value.notificationsMySelf[index].date,
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
