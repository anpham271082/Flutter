
import 'package:flutter/material.dart';
import 'package:my_app_flutter/features/examples/flip_card3d/CardFace.dart';
import 'package:my_app_flutter/features/examples/flip_card3d/FlipCardWidget.dart';

class ExampleFlipCard3D extends StatefulWidget {
  const ExampleFlipCard3D({super.key});

  @override
  State<ExampleFlipCard3D> createState() => _ExampleFlipCard3DState();
}

class _ExampleFlipCard3DState extends State<ExampleFlipCard3D> {
  final List<bool> _cardFlips = List.generate(6, (_) => true);

  final List<String> imageUrls = [
    'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=200&h=280&fit=crop',
    'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=200&h=280&fit=crop',
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=280&fit=crop',
    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200&h=280&fit=crop',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3D Flip Card Pro'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _cardFlips.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          return FlipCardWidget(
            showFront: _cardFlips[index],
            onFlip: () {
              setState(() {
                _cardFlips[index] = !_cardFlips[index];
              });
            },
            front: CardFace(
              color: Colors.deepPurple.shade400,
              icon: Icons.lightbulb_outline,
              imageUrl: imageUrls[index % imageUrls.length],
              title: 'Tap',
              subtitle: 'Front side $index',
            ),
            back: CardFace(
              color: Colors.teal.shade600,
              icon: Icons.check_circle_outline,
              imageUrl: imageUrls[(index + 1) % imageUrls.length],
              title: 'Flipped!',
              subtitle: 'Back side $index',
            ),
          );
        },
      ),
    );
  }
}