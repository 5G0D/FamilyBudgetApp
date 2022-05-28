import 'package:flutter/material.dart';

Future<String?> errorDialog(BuildContext context, String errorText) async {
  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xff2f2f3d),
        title: const Text('Ошибка'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(errorText),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ок'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}