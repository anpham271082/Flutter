import 'package:flutter/material.dart';
import 'package:my_app_flutter/features/examples/example_candidate_model.dart';

class ExampleCard extends StatelessWidget {
  final ExampleCandidateModel candidate;

  const ExampleCard(this.candidate, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480, // Cao chuẩn card Tinder
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.grey.shade200, // Background màu nền cho card
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: 3,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background màu nền nằm dưới cùng
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.grey.shade200, // Màu nền tùy chỉnh
              ),
            ),
          ),

          // Ảnh nền full card, fit cover
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                candidate.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.person, size: 80, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),

          // Background gradient làm tối nhẹ phía trên ảnh để chữ nổi
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.7),
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
            ),
          ),

          // Overlay mờ phía dưới chứa thông tin
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 140,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.85),
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ),

          // Thông tin text phía dưới card
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  candidate.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    shadows: [
                      Shadow(
                        blurRadius: 8,
                        color: Colors.black54,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  candidate.job,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        blurRadius: 6,
                        color: Colors.black45,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 18,
                      color: Colors.white70,
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.black45,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      candidate.city,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        shadows: [
                          Shadow(
                            blurRadius: 5,
                            color: Colors.black45,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
