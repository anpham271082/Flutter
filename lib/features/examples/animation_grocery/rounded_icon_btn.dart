import 'package:flutter/material.dart';

class RoundIconBtn extends StatelessWidget {
  const RoundIconBtn({
    super.key,
    required this.iconData,
    this.color = const Color.fromARGB(255, 64, 169, 68), 
    required this.press,
  });

  final IconData iconData;
  final Color color;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      shape: const CircleBorder(),
      elevation: 0,
      color: Colors.white,
      height: 36,
      minWidth: 36,
      onPressed: press,
      child: Icon(
        iconData,
        color: color,
      ),
    );
  }
}