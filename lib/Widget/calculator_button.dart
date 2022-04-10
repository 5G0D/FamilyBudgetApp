import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({this.child, this.onPressed, this.border, this.color, this.height = 60, Key? key}) : super(key: key);

  final Border? border;
  final Color? color;
  final Widget? child;
  final VoidCallback? onPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: 300,
      decoration: BoxDecoration(
        border: border
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
        ),
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}
