import 'dart:convert';

import 'package:family_budget/Page/account_edit_page.dart';
import 'package:family_budget/category_controller.dart';
import 'package:family_budget/user.dart';
import 'package:family_budget/model/model.dart';
import 'package:family_budget/Page/chat_page.dart';
import 'package:family_budget/Page/forgot_password_page.dart';
import 'package:family_budget/Page/login_page.dart';
import 'package:family_budget/Page/registration_page.dart';
import 'package:family_budget/Theme/custom_theme.dart';
import 'package:family_budget/Theme/config.dart';
import 'package:family_budget/Page/home_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (await FamilyBudget().initializeDB()) {
    runApp(const App());
  } else {
    print('Failed to initialize DB');
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  createState() => _AppState();
}

class _AppState extends State {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
      title: 'Семейный бюджет',
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/chat': (context) => const ChatPage(),
        '/login': (context) => const LoginPage(),
        '/registration': (context) => const RegistrationPage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
        '/account_edit': (context) => const AccountEditPage(),
      },
    );
  }
}
