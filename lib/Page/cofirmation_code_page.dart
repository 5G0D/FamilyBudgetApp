import 'package:email_validator/email_validator.dart';
import 'package:family_budget/Page/Arguments/confirmation_code_arguments.dart';
import 'package:family_budget/Server/Controller/user_controller.dart';
import 'package:family_budget/Server/Response/user_confirm_email_response.dart';
import 'package:family_budget/Server/Response/user_id_response.dart';
import 'package:family_budget/Server/Response/user_response.dart';
import 'package:family_budget/Widget/error_block.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Extansions/snack_bar_utils.dart';

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
                  UserConfirmEmailResponse? userConfirmEmailResponse = await UserController.confirmEmail(context, args.id.toString(), _codeController.text);
                  if (userConfirmEmailResponse?.isEmailConfirm == true){
                      UserResponse? userResponse = await UserController.login(context, args.email, args.password);
                      if (userResponse != null){
                        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                      }
                      else {
                        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
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
