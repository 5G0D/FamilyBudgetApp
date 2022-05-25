import 'package:family_budget/Extansions/snack_bar_utils.dart';
import 'package:family_budget/Page/Arguments/confirmation_code_arguments.dart';
import 'package:family_budget/Server/Controller/user_controller.dart';
import 'package:family_budget/Server/Response/user_id_response.dart';
import 'package:family_budget/Server/Response/user_response.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';

class RecoveryPasswordPassPage extends StatefulWidget {
  const RecoveryPasswordPassPage({Key? key}) : super(key: key);

  @override
  State<RecoveryPasswordPassPage> createState() =>
      _RecoveryPasswordPassPageState();
}

class _RecoveryPasswordPassPageState extends State<RecoveryPasswordPassPage> {
  final _passFormKey = GlobalKey<FormState>();
  final _passController = TextEditingController();
  final _passRepeatController = TextEditingController();

  late ConfirmationCodeArguments args;

  @override
  Widget build(BuildContext context) {
    args =
        ModalRoute.of(context)!.settings.arguments as ConfirmationCodeArguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff5537a1),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _passFormKey,
          child: Column(
            children: [
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
                  controller: _passController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  validator: (value) {
                    if (_passController.text.length < 8) {
                      return 'Пароль должен состоять минимум из 8 символов';
                    } else if (_passController.text != _passController.text) {
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
                  controller: _passRepeatController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  validator: (value) {
                    if (_passController.text != _passRepeatController.text) {
                      return 'Пароли не совпадают';
                    } else {
                      return null;
                    }
                  }),
              Container(
                padding: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_passFormKey.currentState!.validate()) {
                      UserIdResponse? userIdResponse =
                          await UserController.update(args.id,
                              password: _passController.text, context: context);

                      if (userIdResponse != null) {
                        SnackBarUtils.Show(context, 'Пароль успешно изменён');

                        UserResponse? userResponse = await UserController.login(
                            args.email!, _passController.text,
                            context: context);

                        if (userResponse != null) {
                          await User.userLogin(userResponse);

                          if (userResponse.roomId == null) {
                            Navigator.pushReplacementNamed(
                                context, '/room_search');
                          } else {
                            // Room
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                        } else {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false);
                        }
                      }
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passController.dispose();
    _passRepeatController.dispose();
    super.dispose();
  }
}
