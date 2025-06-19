import 'package:flutter/material.dart';
import 'package:my_app_flutter/core/common/styles/styles.dart';
import 'package:my_app_flutter/core/constants/colors.dart';
import 'package:my_app_flutter/core/utils/devices.dart';
import 'package:my_app_flutter/core/utils/files.dart';
import 'package:my_app_flutter/features/base_page.dart';
import 'package:my_app_flutter/features/platform_channel/platform_channel.dart';
import '../google_map/view/pages/map_picker_page.dart';
class SamplesPage extends BasePage {
  const SamplesPage({super.key});
  @override
  State<SamplesPage> createState() => _SamplesPageState();
}
class _SamplesPageState extends BaseState<SamplesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppStyles.preferredSize(),
        body: ListView(
          children: ListTile.divideTiles(context: context, tiles: [
            ListTile(
              leading: Image.asset("assets/icons/ic_menu.png",
                  width: 40.0, height: 40.0, color: AppColors.colorMenu),
              title: Text(
                AppFiles.shared.language("Google Map", "Google Map"),
                style: TextStyle(
                    fontSize: 13 * AppDevices.shared.ratio, color: AppColors.colorMenu),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MapPickerPage()));
              },
            ),
            ListTile(
              leading: Image.asset("assets/icons/ic_menu.png",
                  width: 40.0, height: 40.0, color: AppColors.colorMenu),
              title: Text(
                AppFiles.shared.language("Platform Channel", "Platform Channel"),
                style: TextStyle(
                    fontSize: 13 * AppDevices.shared.ratio, color: AppColors.colorMenu),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const PlatformChannel()));
              },
            ),
          ]).toList(),
        ));
  }
}
