import 'package:family_budget/Page/page_template.dart';
import 'package:family_budget/Widget/error_block.dart';
import 'package:family_budget/current_user_config.dart';
import 'package:family_budget/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _errorBlockVisible = false;

  String _mail = '';
  String _pass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff5537a1),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextField(
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
              onChanged: (value) {
                _mail = value;
              },
            ),
            TextField(
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
              onChanged: (value) {
                _pass = value;
              },
            ),
            ErrorBlock(
              'Логин или пароль неправильный',
              visible: _errorBlockVisible,
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () async {
                        //Проверка на сервере
                        if (false) {
                          setState(() {
                            _errorBlockVisible = true;
                          });
                        } else {
                          UserParam _userParam = (await UserParam()
                                  .getById(CurrentUserConfig.userID)) ??
                              UserParam();
                          _userParam.mail = _mail;
                          _userParam.logged = true;
                          _userParam.save();
                          CurrentUserConfig.logged = true;
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Вход'),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          const Size(200, 40),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        '/registration',
                      ),
                      child: const Text('Регистрация'),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          const Size(200, 40),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        '/forgot_password',
                      ),
                      child: const Text('Забыли пароль?'),
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
          ],
        ),
      ),
    );
  }
}