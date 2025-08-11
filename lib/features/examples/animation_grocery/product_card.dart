import 'fav_btn.dart';
import 'price.dart';
import 'product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.press,
  });

  final Product product;

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: Color(0xFFF7F7F7),
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0 * 1.25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: product.title!,
              child: Image.asset(product.image!),
            ),
            Text(
              product.title!,
            ),
            Text(
              "Fruits",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Price(amount: "20.00"),
                FavBtn(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
