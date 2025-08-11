import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenZoomImage extends StatefulWidget {
  final String imageUrl;

  const FullScreenZoomImage({super.key, required this.imageUrl});

  @override
  State<FullScreenZoomImage> createState() => _FullScreenZoomImageState();
}

class _FullScreenZoomImageState extends State<FullScreenZoomImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Hero( // 👈 Hiệu ứng Hero nếu dùng từ ảnh nhỏ qua ảnh to
            tag: widget.imageUrl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0), // Có thể bo nếu muốn
              child: PhotoView(
                      imageProvider: NetworkImage(widget.imageUrl),
                      backgroundDecoration: BoxDecoration(color: Colors.black),
                      loadingBuilder: (context, event) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorBuilder: (context, error, stackTrace) => const Center(
                        child: Text('Failed to load image', style: TextStyle(color: Colors.white)),
                      ),

                      enableRotation: true,   // Cho phép xoay ảnh

                      minScale: PhotoViewComputedScale.contained * 1.0, // Không cho zoom nhỏ hơn kích thước màn hình
                      maxScale: PhotoViewComputedScale.covered * 3.0,   // Cho phép zoom lớn gấp 3 lần màn hình

                      initialScale: PhotoViewComputedScale.contained,   // Mở đầu ở tỉ lệ vừa đủ chứa trong màn hình
                    ),
            ),
          ),

          // Nút back sáng tạo, bo góc, bóng mờ
          Positioned(
            top: 40,
            left: 16,
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 8,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: 'Back',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}