import 'package:family_budget/Widget/text_icon.dart';
import 'package:family_budget/current_user_config.dart';
import 'package:family_budget/dialogs.dart';
import 'package:family_budget/model/model.dart';
import 'package:flutter/material.dart';

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
          FutureBuilder(
            future: Future.wait(
              [
                UserParam().getById(CurrentUserConfig.userID),
              ],
            ),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                UserParam _userParam = snapshot.data?[0] ?? UserParam();

                Widget _avatar = const SizedBox.shrink();
                if (_userParam.avatar?.isNotEmpty ?? false) {
                  _avatar = Image.memory(
                    _userParam.avatar!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  );
                }

                return InkWell(
                  onTap: () async {
                    if (CurrentUserConfig.logged == true) {
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
                            _userParam.name ?? '',
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
                            Icons.cloud_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
          ListTile(
            title: const TextIcon(
              Icon(Icons.login),
              Text('Вход/регистрация'),
            ),
            onTap: () async {
              if (CurrentUserConfig.logged != true ||
                  (await accountExitDialog(context)) == 'Exit') {
                await Navigator.pushNamed(context, '/login');
                setState(() {});
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
