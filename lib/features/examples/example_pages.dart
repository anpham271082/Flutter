import 'package:flutter/material.dart';
import 'package:my_app_flutter/core/common/styles/styles.dart';
import 'package:my_app_flutter/core/constants/colors.dart';
import 'package:my_app_flutter/core/utils/devices.dart';
import 'package:my_app_flutter/core/utils/files.dart';
import 'package:my_app_flutter/features/base_page.dart';
import 'package:my_app_flutter/features/examples/example_card_swiper.dart';
import 'package:my_app_flutter/features/examples/example_fragmented_image.dart';
import 'package:my_app_flutter/features/examples/example_lottie.dart';
import 'package:my_app_flutter/features/examples/flip_card3d/example_flipcard3d.dart';
import 'package:my_app_flutter/features/examples/hero_transition/example_hero_transition.dart';
import 'package:my_app_flutter/features/examples/shimmer/example_shimmer.dart';
import 'package:my_app_flutter/features/platform_channel/platform_channel.dart';
import 'package:my_app_flutter/features/examples/animation_grocery/example_grocery.dart';
import 'package:my_app_flutter/ripple_shader_example.dart';
import 'package:my_app_flutter/features/examples/example_staggered_animations.dart';

class ExamplePages extends BasePage {
  const ExamplePages({super.key});

  @override
  State<ExamplePages> createState() => _ExamplePagesState();
}

class _ExamplePagesState extends BaseState<ExamplePages> {
  final List<_ExampleItem> _items = [
    _ExampleItem("Platform Channel", const PlatformChannel()),
    _ExampleItem("Hero Transition", const ExampleHeroTransition()),
    _ExampleItem("Lottie", const ExampleLottie()),
    _ExampleItem("Flip Card 3D", const ExampleFlipCard3D()),
    _ExampleItem("Card Swiper",  ExampleCardSwiper()),

    _ExampleItem("Shimmer", const ExampleShimmer()),
    _ExampleItem("Fragmented Image", const ExampleFragmentedImage()),
    //_ExampleItem("Fragmented Image", const RippleShaderExample()),
    _ExampleItem("Grocery List",  ExampleGrocery()),
    _ExampleItem("Staggered Animations",  ExampleStaggeredAnimations()),
    
    //_ExampleItem("Google Map", const MapPickerPage()),  
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppStyles.preferredSize(),
      body: ListView.separated(
        itemCount: _items.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = _items[index];
          return ListTile(
            leading: Image.asset(
              "assets/icons/ic_menu.png",
              width: 40,
              height: 40,
              color: AppColors.colorMenu,
            ),
            title: Text(
              AppFiles.shared.language(item.title, item.title),
              style: TextStyle(
                fontSize: 13 * AppDevices.shared.ratio,
                color: AppColors.colorMenu,
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => item.page));
            },
          );
        },
      ),
    );
  }
}

class _ExampleItem {
  final String title;
  final Widget page;

  const _ExampleItem(this.title, this.page);
}
