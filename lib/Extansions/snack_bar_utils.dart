import 'package:flutter/material.dart';

extension SnackBarUtils on SnackBar {
  static void Show(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [Text(text)])));
  }
}
