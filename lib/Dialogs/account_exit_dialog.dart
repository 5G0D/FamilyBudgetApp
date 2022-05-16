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
              Text('Вы уже вошли в аккаунт.\n'),
              Text('Чтобы продолжить, необходимо выйти из аккаунта.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Выйти из аккаунта'),
            onPressed: () {
              Navigator.pop(context, 'Exit');
            },
          ),
          TextButton(
            child: const Text('Отменить'),
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
          ),
        ],
      );
    },
  );
}
