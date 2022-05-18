import 'package:email_validator/email_validator.dart';
import 'package:family_budget/Page/Arguments/confirmation_code_arguments.dart';
import 'package:family_budget/Server/Controller/user_controller.dart';
import 'package:family_budget/Server/Response/user_id_response.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _regFormKey = GlobalKey<FormState>();

  final TextEditingController _mail = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _passRepeat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff5537a1),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _regFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _mail,
                autofocus: true,
                textInputAction: TextInputAction.next,
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
              TextFormField(
                controller: _userName,
                textInputAction: TextInputAction.next,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  labelText: "Имя пользователя",
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
                validator: (value) => (value?.isEmpty ?? true)
                    ? "Имя пользователя не может быть пустым"
                    : null,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  labelText: "Пароль",
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
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                validator: (value) {
                  if (_pass.text.length < 8) {
                    return 'Пароль должен состоять минимум из 8 символов';
                  } else if (_pass.text != _passRepeat.text) {
                    return 'Пароли не совпадают';
                  } else {
                    return null;
                  }
                },
                controller: _pass,
              ),
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
                    )),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                validator: (value) {
                  if (_pass.text != _passRepeat.text) {
                    return 'Пароли не совпадают';
                  } else {
                    return null;
                  }
                },
                controller: _passRepeat,
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_regFormKey.currentState!.validate()) {
                      UserIdResponse? userIdResp = await UserController.register(context, _userName.text, _mail.text, _pass.text);
                      if (userIdResp != null){
                        Navigator.pushNamed(context, '/registration/confirmation_code', arguments: ConfirmationCodeArguments(id: userIdResp.id, email: _mail.text, password: _pass.text));
                      }
                    }
                  },
                  child: const Text('Зарегистрироваться'),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                      const Size(200, 40),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pass.dispose();
    _passRepeat.dispose();
    _mail.dispose();
    _userName.dispose();
    super.dispose();
  }
}
