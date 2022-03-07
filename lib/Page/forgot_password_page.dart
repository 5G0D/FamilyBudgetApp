import 'package:family_budget/Widget/forgot_password_code_form.dart';
import 'package:family_budget/Widget/forgot_password_mail_form.dart';
import 'package:family_budget/Widget/forgot_password_pass_form.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

enum ForgotPassword {
  mailPage,
  codePage,
  passPage,
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  ForgotPassword _forgotPassword = ForgotPassword.mailPage;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_forgotPassword == ForgotPassword.mailPage)
              ForgotPasswordMailForm(
                () {
                  setState(() {
                    _forgotPassword = ForgotPassword.codePage;
                  });
                },
              ),
            if (_forgotPassword == ForgotPassword.codePage)
              ForgotPasswordCodeForm(
                () {
                  setState(() {
                    _forgotPassword = ForgotPassword.passPage;
                  });
                },
              ),
            if (_forgotPassword == ForgotPassword.passPage)
              const ForgotPasswordPassForm(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pass.dispose();
    _passRepeat.dispose();
    super.dispose();
  }
}
