import 'dart:math';

import 'package:flutter/material.dart';

class FlipCardWidget extends StatefulWidget {
  final bool showFront;
  final VoidCallback onFlip;
  final Widget front;
  final Widget back;

  const FlipCardWidget({
    required this.showFront,
    required this.onFlip,
    required this.front,
    required this.back,
    super.key,
  });

  @override
  State<FlipCardWidget> createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _isFront = widget.showFront;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _triggerFlip() {
    if (_controller.isAnimating) return;
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _isFront = !_isFront;
    widget.onFlip();
  }

  @override
  void didUpdateWidget(covariant FlipCardWidget oldWidget) {
    if (widget.showFront != _isFront) {
      _triggerFlip();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _triggerFlip,
      onHorizontalDragEnd: (_) => _triggerFlip(),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final isFrontVisible = _animation.value < (pi / 2);
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(_animation.value);
          return Transform(
            alignment: Alignment.center,
            transform: transform,
            child: isFrontVisible
                ? widget.front
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: widget.back,
                  ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}