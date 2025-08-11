import 'fav_btn.dart';
import 'price.dart';
import 'product.dart';
import 'package:flutter/material.dart';
import 'cart_counter.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
      {super.key, required this.product, required this.onProductAdd});

  final Product product;
  final VoidCallback onProductAdd;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String _cartTag = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
              onPressed: () {
                widget.onProductAdd();
                setState(() {
                  _cartTag = '_cartTag';
                });
                Navigator.pop(context);
              },
              child: Text("Add to Cart"),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.37,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  color: Color(0xFFF8F8F8),
                  child: Hero(
                    tag: widget.product.title! + _cartTag,
                    child: Image.asset(widget.product.image!),
                  ),
                ),
                Positioned(
                  bottom: -20,
                  child: CartCounter(),
                )
              ],
            ),
          ),
          SizedBox(height: 20.0 * 1.5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.product.title!,
                  ),
                ),
                Price(amount: "20.00"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Cabbage (comprising several cultivars of Brassica oleracea) is a leafy green, red (purple), or white (pale green) biennial plant grown as an annual vegetable crop for its dense-leaved heads. It is descended from the wild cabbage (B. oleracea var. oleracea), and belongs to the cole crops or brassicas, meaning it is closely related to broccoli and cauliflower (var. botrytis); Brussels sprouts (var. gemmifera); and Savoy cabbage (var. sabauda).",
              style: TextStyle(
                color: Color(0xFFBDBDBD),
                height: 1.8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: BackButton(
        color: Colors.black,
      ),
      backgroundColor: Color(0xFFF8F8F8),
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Fruits",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        FavBtn(radius: 20),
        SizedBox(width: 20.0),
      ],
    );
  }
}
