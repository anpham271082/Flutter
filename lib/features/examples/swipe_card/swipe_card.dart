import 'package:flutter/material.dart';

enum SwipeDirection { left, right }

typedef OnSwiped = void Function(SwipeDirection direction);

class SwipeCard extends StatefulWidget {
  final String imageAsset;
  final String title;
  final OnSwiped onSwiped;

  const SwipeCard({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.onSwiped,
  });

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> with TickerProviderStateMixin {
  Offset cardOffset = Offset.zero;
  double rotation = 0;
  Offset startDragOffset = Offset.zero;
  late Size screenSize;

  final double threshold = 100;

  AnimationController? controller;
  Animation<Offset>? animation;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onPanStart: (details) {
        startDragOffset = details.globalPosition;
      },
      onPanUpdate: (details) {
        final dragDistance = details.globalPosition - startDragOffset;
        setState(() {
          cardOffset = dragDistance;
          rotation = dragDistance.dx / 300; // rotation angle
        });
      },
      onPanEnd: (details) {
        if (cardOffset.dx.abs() > threshold) {
          final direction =
              cardOffset.dx > 0 ? SwipeDirection.right : SwipeDirection.left;
          final endOffsetX =
              cardOffset.dx > 0 ? screenSize.width * 2 : -screenSize.width * 2;

          animateCardDismiss(endOffsetX, direction);
        } else {
          animateCardReset();
        }
      },
      child: Transform.translate(
        offset: cardOffset,
        child: Transform.rotate(
          angle: rotation,
          child: SizedBox(
            height: 400, // cố định chiều cao card để tránh lỗi infinite height
            width: double.infinity,
            child: Card(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.hardEdge,
              elevation: 8,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    widget.imageAsset,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      color: Colors.black.withOpacity(0.5),
                      alignment: Alignment.center,
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void animateCardDismiss(double endOffsetX, SwipeDirection direction) {
    controller?.dispose();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = Tween<Offset>(
      begin: cardOffset,
      end: Offset(endOffsetX, cardOffset.dy),
    ).animate(CurvedAnimation(parent: controller!, curve: Curves.easeOut));

    animation!.addListener(() {
      if (!mounted) return;
      setState(() {
        cardOffset = animation!.value;
        rotation = cardOffset.dx / 300;
      });
    });

    controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (!mounted) return;
        widget.onSwiped(direction);
        controller!.dispose();
        controller = null;
      }
    });

    controller!.forward();
  }

  void animateCardReset() {
    controller?.dispose();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = Tween<Offset>(
      begin: cardOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller!, curve: Curves.easeOut));

    animation!.addListener(() {
      if (!mounted) return;
      setState(() {
        cardOffset = animation!.value;
        rotation = cardOffset.dx / 300;
      });
    });

    controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller!.dispose();
        controller = null;
      }
    });

    controller!.forward();
  }
}


