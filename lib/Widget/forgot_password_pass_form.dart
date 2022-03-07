import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPassForm extends StatefulWidget {
  const ForgotPasswordPassForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPassFormState createState() => _ForgotPasswordPassFormState();
}

class _ForgotPasswordPassFormState extends State<ForgotPasswordPassForm> {
  @override
  Widget build(BuildContext context) {
    final _passFormKey = GlobalKey<FormState>();
    String _pass = '', _passRepeat = '';

    return Form(
      key: _passFormKey,
      child: Column(children: [
        TextFormField(
            autofocus: true,
            textInputAction: TextInputAction.next,
            style: const TextStyle(fontSize: 18),
            decoration: const InputDecoration(
              labelText: "Новый пароль",
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff5537a1)),
              ),
            ),
            onChanged: (value) => _pass = value,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            validator: (value) {
              if (_pass.length < 8) {
                return 'Пароль должен состоять минимум из 8 символов';
              } else if (_pass != _passRepeat) {
                return 'Пароли не совпадают';
              } else {
                return null;
              }
            }),
        TextFormField(
            style: const TextStyle(fontSize: 18),
            decoration: const InputDecoration(
              labelText: "Повторите пароль",
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff5537a1)),
              ),
            ),
            onChanged: (value) => _passRepeat = value,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            validator: (value) {
              if (_pass != _passRepeat) {
                return 'Пароли не совпадают';
              } else {
                return null;
              }
            }),
        Container(
          padding: const EdgeInsets.only(top: 20),
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              if (_passFormKey.currentState!.validate()) {
                print('valid');
                Navigator.popUntil(context, (route) => route.isFirst);
              }
            },
            child: const Text('Войти'),
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                const Size(200, 40),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
