import 'package:email_validator/email_validator.dart';
import 'package:family_budget/Extansions/snack_bar_utils.dart';
import 'package:family_budget/Page/Arguments/confirmation_code_arguments.dart';
import 'package:family_budget/Server/Controller/user_controller.dart';
import 'package:family_budget/Server/Response/user_id_response.dart';
import 'package:flutter/material.dart';

class RecoveryPasswordMailPage extends StatefulWidget {
  const RecoveryPasswordMailPage({Key? key}) : super(key: key);

  @override
  State<RecoveryPasswordMailPage> createState() => _RecoveryPasswordMailPageState();
}

class _RecoveryPasswordMailPageState extends State<RecoveryPasswordMailPage> {
  final _mailFormKey = GlobalKey<FormState>();
  final _mailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff5537a1),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _mailFormKey,
          child: Column(children: [
            TextFormField(
              controller: _mailController,
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
                onPressed: () async {
                  if (_mailFormKey.currentState!.validate()) {
                    UserIdResponse? userIdResponse = await UserController.passwordRecovery(context, _mailController.text);
                    if (userIdResponse != null){
                      SnackBarUtils.Show(context, 'Код подтверждения отправлен на почту');
                      Navigator.pushNamed(context, '/recovery_password/code', arguments: ConfirmationCodeArguments(id: userIdResponse.id, email: _mailController.text));
                    }
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
          ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mailController.dispose();
    super.dispose();
  }
}
