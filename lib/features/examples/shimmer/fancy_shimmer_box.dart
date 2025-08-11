import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FancyShimmerBox extends StatefulWidget {
  const FancyShimmerBox({super.key});

  @override
  State<FancyShimmerBox> createState() => _FancyShimmerBoxState();
}

class _FancyShimmerBoxState extends State<FancyShimmerBox> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => isLoading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade700 : Colors.white;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      child: isLoading
          ? Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Container(
                key: const ValueKey('shimmer'),
                height: 220,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [baseColor, highlightColor, baseColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            )
          : Container(
              key: const ValueKey('content'),
              height: 220,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade900 : Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset(0, 4),
                    color: Colors.black12,
                  )
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      bottomLeft: Radius.circular(24),
                    ),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1604537529428-15bcbeecfe4d',
                      height: 220,
                      width: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Stylish Headphones',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Noise-cancelling over-ear headphones with Bluetooth 5.3 and premium comfort.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Spacer(),
                          Text(
                            '\$199.99',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}