import 'package:flutter/material.dart';
import 'package:my_app_flutter/core/common/styles/styles.dart';
import 'package:my_app_flutter/core/constants/colors.dart';
import 'package:my_app_flutter/features/home/model/food_model.dart';
import 'package:my_app_flutter/features/home/view/pages/food_detail_page.dart';

class FoodWidget extends StatelessWidget {
  final List<FoodModel> foods;
  const FoodWidget(this.foods, {super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: foods.length,
        itemBuilder: (context, index) {
          return FoodItemWidget(
            desc: foods[index].desc,
            imgUrl: foods[index].imgUrl,
            title: foods[index].title,
            price: foods[index].price,
            rating: foods[index].rating,
          );
        });
  }
}

class FoodItemWidget extends StatelessWidget {
  final String? imgUrl;
  final String? title;
  final String? desc;
  final String? price;
  final double? rating;
  const FoodItemWidget(
      {super.key, this.imgUrl, this.rating, this.desc, this.price, this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodDetailPage(
                      imgUrl: imgUrl,
                      name: title,
                      desc: desc,
                      rating: rating,
                      price: price,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        decoration: BoxDecoration(
            color: AppColors.colorBackgroundRow, borderRadius: BorderRadius.circular(8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppStyles.clipRRect(
                const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8)),
                imgUrl!,
                90,
                90,
                BoxFit.cover),
            Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppStyles.textTitle(title!),
                  const SizedBox(
                    height: 5,
                  ),
                  AppStyles.textDesc(desc!),
                  const SizedBox(
                    height: 5,
                  ),
                  AppStyles.textPrice(price!),
                ],
              ),
            ),
            const Spacer(),
            Container(
                margin: const EdgeInsets.only(bottom: 0, right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4), color: AppColors.kTaskColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppStyles.textRating("$rating"),
                    const SizedBox(
                      height: 2,
                    ),
                    const Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 20,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
