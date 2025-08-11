import 'home_controller.dart';
import 'product.dart';
import 'details_screen.dart';
import 'package:flutter/material.dart';

import 'cart_details_view.dart';
import 'cart_short_view.dart';
import 'header.dart';
import 'product_card.dart';

// Today i will show you how to implement the animation
// So starting project comes with the UI
// Run the app

class ExampleGrocery extends StatelessWidget {
  final controller = HomeController();

  ExampleGrocery({super.key});

  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta! < -0.7) {
      controller.changeHomeState(HomeState.cart);
    } else if (details.primaryDelta! > 12) {
      controller.changeHomeState(HomeState.normal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text('Grocery List'),
        ),
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Color(0xFFEAEAEA),
          child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return LayoutBuilder(
                  builder: (context, BoxConstraints constraints) {
                    return Stack(
                      children: [
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 500),
                          top: controller.homeState == HomeState.normal
                              ? 85.0
                              : -(constraints.maxHeight -
                                  100.0 * 2 -
                                  85.0),
                          left: 0,
                          right: 0,
                          height: constraints.maxHeight -
                              85.0 -
                              100.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0 ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(20.0 * 1.5),
                                bottomRight:
                                    Radius.circular(20.0 * 1.5),
                              ),
                            ),
                            child: GridView.builder(
                              itemCount: listProducts.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.75,
                                mainAxisSpacing: 20.0,
                                crossAxisSpacing: 20.0,
                              ),
                              itemBuilder: (context, index) => ProductCard(
                                product: listProducts[index],
                                press: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration:
                                          const Duration(milliseconds: 500),
                                      reverseTransitionDuration:
                                          const Duration(milliseconds: 500),
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          FadeTransition(
                                        opacity: animation,
                                        child: DetailsScreen(
                                          product: listProducts[index],
                                          onProductAdd: () {
                                            controller.addProductToCart(
                                                listProducts[index]);
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        // Card Panel
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 500),
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: controller.homeState == HomeState.normal
                              ? 100.0
                              : (constraints.maxHeight - 100.0),
                          child: GestureDetector(
                            onVerticalDragUpdate: _onVerticalGesture,
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              color: Color(0xFFEAEAEA),
                              alignment: Alignment.topLeft,
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 500),
                                child: controller.homeState == HomeState.normal
                                    ? CardShortView(controller: controller)
                                    : CartDetailsView(controller: controller),
                              ),
                            ),
                          ),
                        ),
                        // Header
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 500),
                          top: controller.homeState == HomeState.normal
                              ? 0
                              : -85.0,
                          right: 0,
                          left: 0,
                          height: 85.0,
                          child: HomeHeader(),
                        ),
                      ],
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
