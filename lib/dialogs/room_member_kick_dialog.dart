import 'package:flutter/material.dart';

Future<String?> roomMemberKickDialog(BuildContext context, String userName) async {
  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xff2f2f3d),
        title: const Text('Выгнать пользователя?'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Вы уверены что хотите выгнать пользователя $userName?'),
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