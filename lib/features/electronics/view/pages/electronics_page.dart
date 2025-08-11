import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_flutter/features/electronics/bloc/electronics_bloc.dart';

import '../../../../core/utils/devices.dart';

class ElectronicsPage extends StatelessWidget {
  const ElectronicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Bloc App'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: size.width,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Electronics',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    BlocBuilder<ElectronicsBloc, ElectronicsState>(
                      builder: (context, state) {
                        if (state is ElectronicsInitialState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ElectronicsLoadedState) {
                          return getUI(
                            size: size,
                            uiData: state.electronicsData,
                            scrollDirection: Axis.vertical,
                          );
                        } else {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getUI({
    required Size size,
    required uiData,
    Axis scrollDirection = Axis.horizontal,
  }) {
    return SizedBox(
      height: AppDevices.shared.height - 340,
      child: ListView.builder(
        scrollDirection: scrollDirection,
        itemCount: uiData.length,
        itemBuilder: (context, index) => Card(
          surfaceTintColor: Colors.white,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // ✅ Load ảnh từ URL, fallback nếu lỗi
                Image.network(
                  uiData[index].image,
                  width: size.width / 3,
                  height: size.width / 3,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: size.width / 3,
                      height: size.width / 3,
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: const Text(
                        'No Image',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 5),
                // Nội dung sản phẩm
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        uiData[index].title.length > 20
                            ? '${uiData[index].title.substring(0, 20)}...'
                            : uiData[index].title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Price: \$${uiData[index].price.toStringAsFixed(2)}",
                      ),
                      Text('Category: ${uiData[index].category}'),
                      Text(
                        'Rating: ${uiData[index].rating.rate} (${uiData[index].rating.count})',
                      ),
                      const SizedBox(height: 4),
                      InkWell(
                        onTap: () {
                          // Add to cart logic
                        },
                        child: const Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Add to cart',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
