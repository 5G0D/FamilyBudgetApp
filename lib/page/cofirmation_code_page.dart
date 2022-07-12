import 'package:family_budget/Page/Arguments/confirmation_code_arguments.dart';
import 'package:family_budget/Server/Controller/user_controller.dart';
import 'package:family_budget/Server/Response/user_confirm_email_response.dart';
import 'package:family_budget/Server/Response/user_response.dart';
import 'package:family_budget/Widget/error_block.dart';
import 'package:family_budget/model/controller/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfirmationCodePage extends StatefulWidget {
  const ConfirmationCodePage({Key? key}) : super(key: key);

  @override
  State<ConfirmationCodePage> createState() => _ConfirmationCodePageState();
}

class _ConfirmationCodePageState extends State<ConfirmationCodePage> {
  bool _errorWidgetVisible = false;
  final TextEditingController _codeController = TextEditingController();
  int checkCodeAttempt = 0;
  late ConfirmationCodeArguments args;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as ConfirmationCodeArguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff5537a1),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
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
                LengthLimitingTextInputFormatter(7),
              ],
              controller: _codeController,
            ),
            ErrorBlock(
              'Неверный код подтверждения',
              visible: _errorWidgetVisible,
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  checkCodeAttempt++;
                  UserConfirmEmailResponse? userConfirmEmailResponse = await UserController.confirmEmail(args.id.toString(), _codeController.text, context: context);
                  if (userConfirmEmailResponse?.isEmailConfirm == true){
                    UserResponse? userResponse = await UserController.login(args.email!, args.password!, context: context);
                    if (userResponse != null) {
                      await User.userLogin(userResponse);
                      if (userResponse.roomId == null){
                        Navigator.pushReplacementNamed(context, '/room_search');
                      }
                      else {
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    }
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
          ],),
        )
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }
}
