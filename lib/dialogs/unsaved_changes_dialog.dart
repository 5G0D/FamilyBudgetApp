import 'package:flutter/material.dart';

Future<String?> unsavedChangesDialog(BuildContext context) async {
  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xff2f2f3d),
        title: const Text('Ошибка'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('У Вас есть несохраненные изменения.\n'),
              Text('Вы уверены что хотите выйти?'),
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