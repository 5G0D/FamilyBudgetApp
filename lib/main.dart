import 'package:family_budget/Page/account_edit_page.dart';
import 'package:family_budget/Page/cofirmation_code_page.dart';
import 'package:family_budget/Page/recovery_password_code_page.dart';
import 'package:family_budget/Page/recovery_password_mail_page.dart';
import 'package:family_budget/Page/room_create_page.dart';
import 'package:family_budget/Page/room_edit_page.dart';
import 'package:family_budget/Page/room_page.dart';
import 'package:family_budget/Page/room_search_page.dart';
import 'package:family_budget/room.dart';
import 'package:family_budget/user.dart';
import 'package:family_budget/model/model.dart';
import 'package:family_budget/Page/chat_page.dart';
import 'package:family_budget/Page/login_page.dart';
import 'package:family_budget/Page/registration_page.dart';
import 'package:family_budget/Theme/custom_theme.dart';
import 'package:family_budget/Theme/config.dart';
import 'package:family_budget/Page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Page/recovery_password_pass_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  if (await FamilyBudget().initializeDB()) {
    await User.update();
    await Room.update();

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
      navigatorKey: navigatorKey,
      routes: {
        '/home': (context) => const HomePage(),
        '/chat': (context) => const ChatPage(),
        '/login': (context) => const LoginPage(),
        '/registration': (context) => const RegistrationPage(),
        '/registration/confirmation_code': (context) => const ConfirmationCodePage(),
        '/recovery_password': (context) => const RecoveryPasswordMailPage(),
        '/recovery_password/code': (context) => const RecoveryPasswordCodePage(),
        '/recovery_password/code/pass': (context) => const RecoveryPasswordPassPage(),
        '/account_edit': (context) => const AccountEditPage(),
        '/room': (context) => const RoomPage(),
        '/room/edit': (context) => const RoomEditPage(),
        '/room_search': (context) => const RoomSearchPage(),
        '/room_search/create': (context) => const RoomCreatePage(),
      },
    );
  }
}
