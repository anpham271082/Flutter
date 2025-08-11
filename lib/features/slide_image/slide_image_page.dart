import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/features/slide_image/fullscreen_zoom_image.dart';

class SlideImagePage extends StatefulWidget {
  const SlideImagePage({super.key});

  @override
  State<SlideImagePage> createState() => _SlideImagePageState();
}

class _SlideImagePageState extends State<SlideImagePage> {
  final List<String> imageUrls = [
    'https://picsum.photos/id/1015/600/400',
    'https://picsum.photos/id/1016/600/400',
    'https://picsum.photos/id/1018/600/400',
    'https://picsum.photos/id/1020/600/400',
  ];

  CarouselSliderController carouselController = CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slide Image Carousel')),
      body: Column(
        children: [
          const SizedBox(height: 20),

          /// Carousel with image click
          CarouselSlider.builder(
            carouselController: carouselController,
            itemCount: imageUrls.length,
            itemBuilder: (context, index, realIndex) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FullScreenZoomImage(
                        imageUrl: imageUrls[index],
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 240,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              enableInfiniteScroll: true,
              viewportFraction: 0.7,
              onPageChanged: (index, reason) {
                setState(() => _currentIndex = index);
              },
            ),
          ),

          const SizedBox(height: 16),

          /// Dot indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageUrls.asMap().entries.map((entry) {
              final isSelected = _currentIndex == entry.key;
              return GestureDetector(
                onTap: () => carouselController.animateToPage(entry.key),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isSelected ? 12 : 8,
                  height: isSelected ? 12 : 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? Colors.blueAccent : Colors.grey,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}