import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerGridProduct extends StatefulWidget {
  const ShimmerGridProduct({super.key});

  @override
  State<ShimmerGridProduct> createState() => _ShimmerGridProductState();
}

class _ShimmerGridProductState extends State<ShimmerGridProduct>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  // Mẫu dữ liệu sản phẩm demo
  final List<Map<String, dynamic>> products = [
    {
      'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
      'title': 'Wireless Headphones',
      'price': 199.99,
    },
    {
      'image': 'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?auto=format&fit=crop&w=800&q=80',
      'title': 'Smart Watch',
      'price': 149.99,
    },
    {
      'image': 'https://images.unsplash.com/photo-1500534623283-312aade485b7?auto=format&fit=crop&w=800&q=80',
      'title': 'Running Shoes',
      'price': 89.99,
    },
    {
      'image': 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?auto=format&fit=crop&w=800&q=80',
      'title': 'Digital Camera',
      'price': 349.99,
    },
    {
      'image': 'https://images.unsplash.com/photo-1503264116251-35a269479413?auto=format&fit=crop&w=800&q=80',
      'title': 'Leather Bag',
      'price': 129.99,
    },
    {
      'image': 'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?auto=format&fit=crop&w=800&q=80',
      'title': 'Desk Lamp',
      'price': 39.99,
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => isLoading = false);
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey.shade300;
    final highlightColor = Colors.grey.shade100;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isLoading
          ? Shimmer.fromColors(
              key: const ValueKey('shimmer'),
              baseColor: baseColor,
              highlightColor: highlightColor,
              period: const Duration(milliseconds: 1500),
              child: GridView.builder(
                itemCount: products.length,
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (_, __) => Container(
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(height: 12, width: 100, color: baseColor),
                      const SizedBox(height: 8),
                      Container(height: 12, width: 60, color: baseColor),
                    ],
                  ),
                ),
              ),
            )
          : FadeTransition(
              key: const ValueKey('content'),
              opacity: _fadeAnimation,
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: products.length,
                itemBuilder: (_, index) {
                  final product = products[index];
                  return _buildProductCard(
                    imageUrl: product['image'],
                    title: product['title'],
                    price: product['price'],
                  );
                },
              ),
            ),
    );
  }

  Widget _buildProductCard({
    required String imageUrl,
    required String title,
    required double price,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(blurRadius: 10, color: Colors.black12, offset: Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '\$${price.toStringAsFixed(2)}',
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.deepOrange),
            ),
          ),
        ],
      ),
    );
  }
}