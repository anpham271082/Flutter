import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FoodTileWidget extends StatelessWidget {
  final String? imgUrl;
  const FoodTileWidget({super.key, this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: imgUrl!,
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
