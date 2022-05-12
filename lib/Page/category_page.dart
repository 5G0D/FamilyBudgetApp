import 'package:family_budget/Behavior/scroll_behavior.dart';
import 'package:family_budget/Page/login_page.dart';
import 'package:family_budget/Page/page_template.dart';
import 'package:family_budget/categories_list.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';

import '../model/model.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({required this.userId, Key? key}) : super(key: key);

  final int userId;

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _categoriesType = 1;

  int get currentType => _categoriesType;

  void changeCurrentType() {
    _categoriesType = _categoriesType == 0 ? 1 : 0;
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
          return ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: FutureBuilder(
              future: Future.wait(
                [
                  CategoriesList.getCategoryBlocks(
                    widget.userId,
                    constraints.maxWidth / 4,
                    constraints.maxHeight / 4,
                    currentType,
                    _refresh,
                    changeCurrentType,
                  ),
                ],
              ),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<List<dynamic>>> snapshot,
              ) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data![0].length,
                    itemBuilder: (context, index) {
                      return snapshot.data![0][index];
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
        },
      ),
    );
  }
}
