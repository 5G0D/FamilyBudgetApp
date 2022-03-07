import 'package:email_validator/email_validator.dart';
import 'package:family_budget/Widget/error_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPasswordCodeForm extends StatefulWidget {
  const ForgotPasswordCodeForm(this.changeForm, {Key? key}) : super(key: key);

  final Function() changeForm;

  @override
  _ForgotPasswordCodeFormState createState() => _ForgotPasswordCodeFormState();
}

class _ForgotPasswordCodeFormState extends State<ForgotPasswordCodeForm> {
  bool _errorWidgetVisible = false;
  String _verifyCode = '';
  int checkCodeAttempt = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(children: [
        TextFormField(
          autofocus: true,
          style: const TextStyle(fontSize: 18),
          decoration: const InputDecoration(
            labelText: "Код подтверждения",
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
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            LengthLimitingTextInputFormatter(6),
          ],
          onChanged: (value) => _verifyCode = value,
        ),
        ErrorBlock(
          'Неверный код подтверждения',
          visible: _errorWidgetVisible,
        ),
        Container(
          padding: const EdgeInsets.only(top: 20),
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              checkCodeAttempt++;

              if (_verifyCode == '1') {
                widget.changeForm();
              } else if (checkCodeAttempt > 2) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Превышено число попыток ввода кода"),
                  ),
                );
                Navigator.pop(context);
              } else {
                setState(() {
                  _errorWidgetVisible = true;
                });
              }
            },
            child: const Text('Ввести код'),
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
