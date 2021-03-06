import 'package:family_budget/Behavior/scroll_behavior.dart';
import 'package:flutter/material.dart';

import '../controller/categories_list.dart';
import '../model/controller/category.dart' as c;

class CategoryPage extends StatefulWidget {
  const CategoryPage({required this.userId, required this.refresh, Key? key}) : super(key: key);

  final int userId;
  final Function refresh;

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  static int _categoriesType = 1;

  int get currentType => _categoriesType;

  void changeCurrentType() {
    _categoriesType = _categoriesType == 0 ? 1 : 0;
  }

  void _refresh() {
    setState(() {});
  }

  Future<void> _update() async {
    await c.Category.serverUpdateAll();
    widget.refresh();
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
                  return RefreshIndicator(
                    onRefresh: _update,
                    child: ListView.builder(
                      itemCount: snapshot.data![0].length,
                      itemBuilder: (context, index) {
                        return snapshot.data![0][index];
                      },
                    ),
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
