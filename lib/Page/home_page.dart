import 'package:family_budget/Page/category_page.dart';
import 'package:family_budget/Page/login_page.dart';
import 'package:family_budget/Page/page_template.dart';
import 'package:family_budget/model/model.dart';
import 'package:flutter/material.dart';

import '../user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController(initialPage: 999);

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if ((User.params.user_id ?? 0) == 0) {
      return const LoginPage();
    }

    return PageTemplate(
      child: FutureBuilder(
          future: Future.wait(
            [
              RoomMember().select().status.not.equals(0).toList(),
            ],
          ),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              List<RoomMember> members = snapshot.data[0]!;
              int userId = User.params.user_id!;
              members.sort((a, b) => b.user_id == userId ? 1 : -1);

              if (members.isNotEmpty) {
                return PageView.builder(
                  itemBuilder: (context, index) {
                    return CategoryPage(
                        userId: members[index % members.length].user_id!);
                  },
                  controller: pageController,
                );
              } else {
                return CategoryPage(userId: userId);
              }
            }

            return const Center(child: CircularProgressIndicator());
          }),
      refreshFunc: _refresh,
    );
  }
}
