import 'package:family_budget/Page/category_page.dart';
import 'package:family_budget/Page/login_page.dart';
import 'package:family_budget/Page/page_template.dart';
import 'package:family_budget/Page/room_search_page.dart';
import 'package:family_budget/model/controller/category.dart' as c;
import 'package:family_budget/model/controller/room.dart';
import 'package:family_budget/model/model.dart' as m;
import 'package:flutter/material.dart';

import '../model/controller/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController(initialPage: 0);
  static bool _updating  = false;

  void _refresh() {
    setState(() {});
  }

  Future<void> _update() async {
    _updating = true;
    await Room.serverUpdate(sample: true);
    await c.Category.serverUpdateAll();
    _updating = false;
  }

  @override
  Widget build(BuildContext context) {
    if ((User.params.user_id ?? 0) == 0) {
      return const LoginPage();
    }
    if ((Room.params.room_id ?? 0) == 0) {
      return const RoomSearchPage();
    }

    return PageTemplate(
      child: FutureBuilder(
          future: Future.wait(
            [
              m.RoomMember().select().status.not.equals(0).toList(),
            ],
          ),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              List<m.RoomMember> members = snapshot.data[0]!;
              int userId = User.params.user_id!;
              members.sort((a, b) => b.user_id == userId ? 1 : -1);

              if (members.isNotEmpty) {
                return PageView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    return CategoryPage(
                      userId: members[index].user_id!,
                      refresh: _refresh,
                    );
                  },
                  controller: pageController,
                );
              }
            }

            return const Center(child: CircularProgressIndicator());
          }),
      refreshFunc: _refresh,
    );
  }

  @override
  void initState() {
    super.initState();
    if (!_updating){
      _update();
    }
  }
}
