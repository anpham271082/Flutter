import 'package:flutter/material.dart';
import '/core/constants/colors.dart';
import '/core/utils/devices.dart';
class MenuCategory {
  late int index;
  late int indexSelected;
  late String name;
  MenuCategory({required this.index, required this.indexSelected, required this.name});
}
class MenuCategoryWidget extends StatelessWidget {
  final MenuCategory menuCategory;
  final Function(int) onClicked;
  final VoidCallback callbackOnClicked;
  const MenuCategoryWidget(this.menuCategory, {super.key, required this.onClicked, required this.callbackOnClicked});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: GestureDetector(
        child: Text(
          menuCategory.name,
          style: TextStyle(
              fontSize: 13 * AppDevices.shared.ratio,
              fontWeight: FontWeight.w600,
              color: menuCategory.index == menuCategory.indexSelected
                  ? AppColors.colorMenuCategory
                  : AppColors.colorCategoryTitle),
        ),
        onTap: () {
           callbackOnClicked();
           onClicked(menuCategory.index);
        },
      ),
    );
  }
}