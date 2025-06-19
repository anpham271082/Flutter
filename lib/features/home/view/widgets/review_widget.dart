import 'package:flutter/material.dart';
import 'package:my_app_flutter/core/constants/colors.dart';
class ReviewWidget extends StatelessWidget {
  final String? title;
  final String? noOfReviews;
  final double? rating;
  const ReviewWidget({super.key, this.rating, this.title, this.noOfReviews});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: const Color(0xffE9F4F9),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: const Color(0xffD5E6F2),
                      borderRadius: BorderRadius.circular(8)),
                  child: Image.asset(
                    "assets/icons/ic_card1.png",
                    height: 30,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Yêu thích",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.colorTextInput),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "8.0/10",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.colorTextInput),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              " Based on 30 reviews",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.colorTextInput),
            ),
          ],
        ));
  }
}