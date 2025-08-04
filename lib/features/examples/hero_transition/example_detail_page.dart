import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ExampleDetailPage extends StatelessWidget {
  final String imageUrl;
  final String heroTag;

  const ExampleDetailPage({
    super.key,
    required this.imageUrl,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.95),
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: heroTag,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                  fadeInDuration: const Duration(milliseconds: 400),
                  height: MediaQuery.of(context).size.height * 0.75,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey.shade900,
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: const Icon(
                      Icons.broken_image,
                      size: 64,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close_rounded, size: 34, color: Colors.white),
              onPressed: () => Navigator.pop(context),
              tooltip: 'Close',
            ),
          ),
        ],
      ),
    );
  }
}