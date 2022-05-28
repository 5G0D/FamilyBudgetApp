import 'package:flutter/material.dart';

class ErrorBlock extends StatelessWidget {
  const ErrorBlock(this.text, {Key? key, this.visible = true, this.width = 250, this.height = 30}) : super(key: key);

  final bool visible;
  final double width;
  final double height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.red.withAlpha(100),
            border: Border.all(
              color: Colors.red.withAlpha(100),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Text(text),
      ),
    );
  }
}