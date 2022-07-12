import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget {
  const TextIcon(this.icon, this.text,
      {Key? key, this.spaceBetween, this.mainAxisAlignment})
      : super(key: key);

  final Text text;
  final Icon icon;
  final double? spaceBetween;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        icon,
        SizedBox(width: spaceBetween ?? 5),
        text,
      ],
    );
  }
}
