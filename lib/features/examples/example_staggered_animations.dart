import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ExampleStaggeredAnimations extends StatelessWidget {
  const ExampleStaggeredAnimations({super.key});

  final int itemCount = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Staggered Animations')),
      body: AnimationLimiter(
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.75, // Để có chỗ cho text bên dưới ảnh
          ),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 600),
              columnCount: 3,
              child: ScaleAnimation(
                scale: 0.9,
                child: FadeInAnimation(
                  child: _buildCard(index),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCard(int index) {
    final imageUrls = [
      'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
      'https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=400&q=80',
      'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?auto=format&fit=crop&w=400&q=80',
      'https://images.unsplash.com/photo-1500534623283-312aade485b7?auto=format&fit=crop&w=400&q=80',
      'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?auto=format&fit=crop&w=400&q=80',
      'https://images.unsplash.com/photo-1518837695005-2083093ee35b?auto=format&fit=crop&w=400&q=80',
    ];

    final badges = ['NEW', 'HOT', 'SALE', 'TREND', 'BEST', ''];

    final imageUrl = imageUrls[index % imageUrls.length];
    final badgeText = badges[index % badges.length];

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
                    ),
                  ),
                ),
                if (badgeText.isNotEmpty)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [Colors.redAccent, Colors.deepOrange],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent.withOpacity(0.5),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        badgeText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Item $index',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}