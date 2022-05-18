import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';

Future<String?> accountExitDialog(BuildContext context) async {
  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xff2f2f3d),
        title: const Text('Выход из аккаунта'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Вы уверены что хотите выйти из аккаунта?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Да'),
            onPressed: () {
              Navigator.pop(context, 'YES');
            },
          ),
          TextButton(
            child: const Text('Нет'),
            onPressed: () {
              Navigator.pop(context, 'NO');
            },
          ),
        ],
      );
    },
  );
}
