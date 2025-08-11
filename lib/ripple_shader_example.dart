import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class RippleShaderExample extends StatefulWidget {
  const RippleShaderExample({super.key});

  @override
  State<RippleShaderExample> createState() => _RippleShaderExampleState();
}

class _RippleShaderExampleState extends State<RippleShaderExample> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Offset _touch = const Offset(-1, -1);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1000))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateTouch(Offset localPos, Size size) {
    setState(() {
      _touch = Offset(localPos.dx / size.width, localPos.dy / size.height);
    });
  }

  void _clearTouch() {
    setState(() {
      _touch = const Offset(-1, -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onPanDown: (e) => _updateTouch(e.localPosition, size),
      onPanUpdate: (e) => _updateTouch(e.localPosition, size),
      onPanEnd: (_) => _clearTouch(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ShaderBuilder(
            assetKey: 'assets/shaders/ripple.frag',
            (context, shader, child) {
              shader.setFloat(0, _controller.value * 1000);
              shader.setFloat(1, size.width);
              shader.setFloat(2, size.height);
              shader.setFloat(3, _touch.dx);
              shader.setFloat(4, _touch.dy);

              return CustomPaint(
                painter: _ShaderPainter(shader),
                size: size,
              );
            },
          );
        },
      ),
    );
  }
}

class _ShaderPainter extends CustomPainter {
  final FragmentShader shader;
  _ShaderPainter(this.shader);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant _ShaderPainter oldDelegate) => true;
}
