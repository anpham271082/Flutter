import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/core/utils/devices.dart';
import '/core/constants/colors.dart';
class AppStyles {
  static PreferredSize preferredSize() => PreferredSize(
      preferredSize: const Size.fromHeight(0),
      child: AppBar(
        backgroundColor: AppColors.kWhiteColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ));
  static ClipRRect clipRRect(BorderRadius borderRadius, String imageUrl,
          double width, double height, BoxFit boxFit) =>
      ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: boxFit,
        ),
      );
  static Text categoryTitle(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 13 * AppDevices.shared.ratio,
            fontWeight: FontWeight.w600,
            color: AppColors.colorCategoryTitle),
      );
  //Food
  static Text textTitle(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 13 * AppDevices.shared.ratio,
            fontWeight: FontWeight.w600,
            color: AppColors.colorTitle),
      );
  static Text textDesc(String desc) => Text(
        desc,
        style: TextStyle(
            fontSize: 12 * AppDevices.shared.ratio,
            fontWeight: FontWeight.w400,
            color: AppColors.colorDesc),
      );
  static Text textPrice(String price) => Text(
        price,
        style: TextStyle(
            fontSize: 12 * AppDevices.shared.ratio,
            fontWeight: FontWeight.w400,
            color: AppColors.colorPrice),
      );
  static Text textRating(String rating) => Text(
        rating,
        style: TextStyle(
            fontSize: 11 * AppDevices.shared.ratio,
            fontWeight: FontWeight.w600,
            color: AppColors.colorRating),
      );
  //Favourite
  static Text textFavouriteTitle(String title) => Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
            fontSize: 13 * AppDevices.shared.ratio,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFavouriteTitle),
      );
  static Text textFavouritePrice(String price) => Text(
        price,
        style: TextStyle(
            fontSize: 11 * AppDevices.shared.ratio,
            fontWeight: FontWeight.w400,
            color: AppColors.colorFavouritePrice),
      );
  static Text textFavouriteRating(String rating) => Text(
        rating,
        style: TextStyle(
            fontSize: 11 * AppDevices.shared.ratio,
            fontWeight: FontWeight.w400,
            color: AppColors.colorFavouriteRating),
      );
  //Tabbar Notification
  static Tab tabTitle(String title) => Tab(
        child: Text(
          title,
          style: TextStyle(
              fontSize: 13 * AppDevices.shared.ratio,
              fontWeight: FontWeight.w600),
        ),
      );
  static Container searchContainer(String hintText) => Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        height: 40,
        width: double.infinity,
        child: TextField(
          style: TextStyle(
              fontSize: 13 * AppDevices.shared.ratio,
              height: 1,
              color: AppColors.colorTextInput),
          cursorColor: AppColors.colorTextInput,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Colors.black87)),
            prefixIcon: const SizedBox(
                width: 30,
                child: Icon(
                  Icons.search,
                  color: AppColors.colorTextInput,
                  size: 24,
                )),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.colorTextInput, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(4))),
          ),
        ),
      );
  static TextFormField textFormField(
          TextEditingController textEditingController,
          FocusNode focusNode,
          String labelText,
          Function()? requestFocus,
          Image image,
          AsyncSnapshot snapshot,
          {bool obscureText = false}) =>
      TextFormField(
          controller: textEditingController,
          style: TextStyle(
              fontSize: 13 * AppDevices.shared.ratio,
              height: 1,
              color: AppColors.colorTextInput),
          obscureText: obscureText,
          cursorColor: AppColors.colorTextInput,
          keyboardType: TextInputType.emailAddress,
          focusNode: focusNode,
          onTap: requestFocus,
          decoration: InputDecoration(
              //errorText:snapshot.hasError?snapshot.error:null,
              isDense: true,
              labelText: labelText,
              labelStyle: TextStyle(
                  color: focusNode.hasFocus ? Colors.black87 : AppColors.colorTextInput),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(color: Colors.black87)),
              prefixIcon: SizedBox(
                  width: 30,
                  child: image), // Image.asset("assets/ic_phone.png")),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.colorTextInput, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(4)))));
}
