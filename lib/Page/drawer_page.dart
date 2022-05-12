import 'package:family_budget/Dialogs/account_exit_dialog.dart';
import 'package:family_budget/Icon/family_budget_icons_icons.dart';
import 'package:family_budget/Widget/text_icon.dart';
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
        children: [
          Builder(
            builder: (BuildContext context) {
              if ((User.params.user_id ?? 0) != 0) {
                Widget _avatar = const SizedBox.shrink();
                if (User.params.avatar?.isNotEmpty ?? false) {
                  _avatar = Image.memory(
                    User.params.avatar!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  );
                }

                return InkWell(
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
                    color: const Color(0xff5537a1),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: _avatar,
                        ),
                        Container(
                          width: 200,
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
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          ListTile(
            title: const TextIcon(
              Icon(Icons.login),
              Text('Вход/регистрация'),
            ),
            onTap: () async {
              if ((User.params.user_id ?? 0) == 0 ||
                  (await accountExitDialog(context)) == 'Exit') {
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
