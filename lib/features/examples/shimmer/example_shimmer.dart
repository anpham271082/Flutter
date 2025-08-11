import 'package:flutter/material.dart';
import 'package:my_app_flutter/features/examples/shimmer/fancy_shimmer_box.dart';
import 'package:my_app_flutter/features/examples/shimmer/shimmer_grid_product.dart';
import 'package:my_app_flutter/features/examples/shimmer/shimmer_profile.dart';
class ExampleShimmer extends StatelessWidget {
  const ExampleShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shimmer'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Grid'),
              Tab(text: 'Profile'),
              Tab(text: 'Gradient'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            const ShimmerGridProduct(),
            const ShimmerProfile(),
            const FancyShimmerBox(),
          ],
        ),
      ),
    );
  }
}