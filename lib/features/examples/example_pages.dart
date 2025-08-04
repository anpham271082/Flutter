import 'package:flutter/material.dart';
import 'package:my_app_flutter/core/common/styles/styles.dart';
import 'package:my_app_flutter/core/constants/colors.dart';
import 'package:my_app_flutter/core/utils/devices.dart';
import 'package:my_app_flutter/core/utils/files.dart';
import 'package:my_app_flutter/features/base_page.dart';
import 'package:my_app_flutter/features/examples/example_lottie.dart';
import 'package:my_app_flutter/features/examples/flip_card3d/example_flipcard3d.dart';
import 'package:my_app_flutter/features/examples/hero_transition/example_hero_transition.dart';
import 'package:my_app_flutter/features/platform_channel/platform_channel.dart';
import '../google_map/view/pages/map_picker_page.dart';
class ExamplePages extends BasePage {
  const ExamplePages({super.key});
  @override
  State<ExamplePages> createState() => _ExamplePagesState();
}
class _ExamplePagesState extends BaseState<ExamplePages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppStyles.preferredSize(),
        body: ListView(
          children: ListTile.divideTiles(context: context, tiles: [
            /*ListTile(
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
            ),*/
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

            ListTile(
              leading: Image.asset("assets/icons/ic_menu.png",
                  width: 40.0, height: 40.0, color: AppColors.colorMenu),
              title: Text(
                AppFiles.shared.language("Hero Transition", "Hero Transition"),
                style: TextStyle(
                    fontSize: 13 * AppDevices.shared.ratio, color: AppColors.colorMenu),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ExampleHeroTransition()));
              },
            ),

            ListTile(
              leading: Image.asset("assets/icons/ic_menu.png",
                  width: 40.0, height: 40.0, color: AppColors.colorMenu),
              title: Text(
                AppFiles.shared.language("Lottie", "Lottie"),
                style: TextStyle(
                    fontSize: 13 * AppDevices.shared.ratio, color: AppColors.colorMenu),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ExampleLottie()));
              },
            ),

            ListTile(
              leading: Image.asset("assets/icons/ic_menu.png",
                  width: 40.0, height: 40.0, color: AppColors.colorMenu),
              title: Text(
                AppFiles.shared.language("Flip Card 3D", "Flip Card 3D"),
                style: TextStyle(
                    fontSize: 13 * AppDevices.shared.ratio, color: AppColors.colorMenu),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ExampleFlipCard3D()));
              },
            ),

          ]).toList(),
        ));
  }
}
