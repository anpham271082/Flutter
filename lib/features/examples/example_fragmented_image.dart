import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ExampleFragmentedImage extends StatefulWidget {
  const ExampleFragmentedImage({super.key});

  @override
  State<ExampleFragmentedImage> createState() => _ExampleFragmentedImageState();
}

class _ExampleFragmentedImageState extends State<ExampleFragmentedImage>
    with SingleTickerProviderStateMixin {
  static const int rows = 8;
  static const int cols = 8;
  static const String imageUrl =
      'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80';

  late AnimationController _controller;
  late ImageStream _imageStream;
  late ImageInfo _imageInfo;
  bool imageLoaded = false;
  bool exploded = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    final imageProvider = NetworkImage(imageUrl);
    _imageStream = imageProvider.resolve(ImageConfiguration.empty);
    _imageStream.addListener(
      ImageStreamListener((info, _) {
        setState(() {
          _imageInfo = info;
          imageLoaded = true;

          // Start exploded, then auto reassemble
          _controller.value = 1.0;
          exploded = true;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _controller.reverse().then((_) {
              setState(() {
                exploded = false;
              });
            });
          });
        });
      }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleExplosion() {
    if (!exploded) {
      _controller.forward().then((_) {
        setState(() {
          exploded = true;
        });
      });
    } else {
      _controller.reverse().then((_) {
        setState(() {
          exploded = false;
        });
      });
    }
  }

  Widget buildTile(int row, int col, double tileSize) {
    final xOffset = col * tileSize;
    final yOffset = row * tileSize;
    final centerX = (cols / 2 - 0.5) * tileSize;
    final centerY = (rows / 2 - 0.5) * tileSize;
    final dx = xOffset - centerX;
    final dy = yOffset - centerY;
    final distance = sqrt(dx * dx + dy * dy);
    final angle = atan2(dy, dx);

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final progress = Curves.easeOutCubic.transform(_controller.value);
        final offset = Offset(
          cos(angle) * distance * progress,
          sin(angle) * distance * progress,
        );

        final opacity = 1 - progress;
        final scale = 1.0 - 0.3 * progress;

        return Positioned(
          left: xOffset + offset.dx,
          top: yOffset + offset.dy,
          width: tileSize,
          height: tileSize,
          child: Opacity(
            opacity: opacity,
            child: Transform.scale(
              scale: scale,
              child: CustomPaint(
                size: Size(tileSize, tileSize),
                painter: TileImagePainter(
                  image: _imageInfo.image,
                  imageSize: Size(
                    _imageInfo.image.width.toDouble(),
                    _imageInfo.image.height.toDouble(),
                  ),
                  row: row,
                  col: col,
                  rows: rows,
                  cols: cols,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.9;
    final tileSize = size / cols;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Fragmented Image Explosion'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: imageLoaded
            ? SizedBox(
                width: size,
                height: size,
                child: Stack(
                  children: [
                    for (int row = 0; row < rows; row++)
                      for (int col = 0; col < cols; col++)
                        buildTile(row, col, tileSize),
                  ],
                ),
              )
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: imageLoaded
          ? FloatingActionButton.extended(
              backgroundColor: Colors.deepPurple,
              label: Text(exploded ? 'Reassemble' : 'Explode'),
              icon: Icon(exploded ? Icons.undo : Icons.auto_awesome),
              onPressed: toggleExplosion,
            )
          : null,
    );
  }
}

class TileImagePainter extends CustomPainter {
  final ui.Image image;
  final Size imageSize;
  final int row, col, rows, cols;

  TileImagePainter({
    required this.image,
    required this.imageSize,
    required this.row,
    required this.col,
    required this.rows,
    required this.cols,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final tileWidth = imageSize.width / cols;
    final tileHeight = imageSize.height / rows;

    final src = Rect.fromLTWH(
      col * tileWidth,
      row * tileHeight,
      tileWidth,
      tileHeight,
    );

    final dst = Rect.fromLTWH(0, 0, size.width, size.height);

    final paint = Paint();
    canvas.drawImageRect(image, src, dst, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
