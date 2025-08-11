import 'price.dart';
import 'product_item.dart';
import 'package:flutter/material.dart';

class CartDetailsViewCard extends StatelessWidget {
  const CartDetailsViewCard({
    super.key,
    required this.productItem,
  });

  final ProductItem productItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 20.0 / 2),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(productItem.product!.image!),
      ),
      title: Text(
        productItem.product!.title!
      ),
      trailing: FittedBox(
        child: Row(
          children: [
            Price(amount: "20"),
            Text(
              "  x ${productItem.quantity}",
            )
          ],
        ),
      ),
    );
  }
}
