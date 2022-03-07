import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ForgotPasswordMailForm extends StatefulWidget {
  const ForgotPasswordMailForm(this.changeForm, {Key? key}) : super(key: key);

  final Function() changeForm;

  @override
  _ForgotPasswordMailFormState createState() => _ForgotPasswordMailFormState();
}

class _ForgotPasswordMailFormState extends State<ForgotPasswordMailForm> {
  @override
  Widget build(BuildContext context) {
    final _mailFormKey = GlobalKey<FormState>();

    return Form(
      key: _mailFormKey,
      child: Column(children: [
        TextFormField(
          autofocus: true,
          style: const TextStyle(fontSize: 18),
          decoration: const InputDecoration(
            labelText: "Адрес электронной почты",
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
          validator: (value) => EmailValidator.validate(value ?? '')
              ? null
              : "Некорректный адрес электронной почты",
        ),
        Container(
          padding: const EdgeInsets.only(top: 20),
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              if (_mailFormKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Код подтверждения отправлен на почту',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
                widget.changeForm();
              }
            },
            child: const Text('Получить код'),
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
