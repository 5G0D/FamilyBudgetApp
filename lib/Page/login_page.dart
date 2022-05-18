import 'package:family_budget/Page/page_template.dart';
import 'package:family_budget/Server/Controller/user_controller.dart';
import 'package:family_budget/Server/Response/user_response.dart';
import 'package:family_budget/Widget/error_block.dart';
import 'package:family_budget/user.dart';
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
                        UserResponse? userResponse = await UserController.login(context, _mail, _pass);
                        if (userResponse != null) {
                          await User.newUserInit();
                          await User.update();
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          setState(() {
                            _errorBlockVisible = true;
                          });
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
