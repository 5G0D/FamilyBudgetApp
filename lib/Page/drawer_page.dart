import 'package:family_budget/Dialogs/account_exit_dialog.dart';
import 'package:family_budget/Icon/family_budget_icons_icons.dart';
import 'package:family_budget/Widget/text_icon.dart';
import 'package:family_budget/room.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';

import '../model/model.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff2f2f3d),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    '/room',
                  );
                  setState(() {});
                },
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 80),
                  decoration: BoxDecoration(
                    color: const Color(0xff4a3480),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.memory(
                            Room.params.avatar!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              Room.params.name ?? '',
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  if ((User.params.user_id ?? 0) != 0) {
                    await Navigator.pushNamed(
                      context,
                      '/account_edit',
                    );
                  } else {
                    await Navigator.pushNamed(
                      context,
                      '/login',
                    );
                  }
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 80,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Image.memory(
                          User.params.avatar!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            User.params.name ?? '',
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: const Icon(
                          FamilyBudgetIcons.signal,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff5537a1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            title: const TextIcon(
              Icon(Icons.login),
              Text('Вход/регистрация'),
            ),
            onTap: () async {
              if ((User.params.user_id ?? 0) == 0 ||
                  (await accountExitDialog(context)) == 'Exit') {
                await User.userExit();
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
