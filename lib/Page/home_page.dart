import 'package:family_budget/Behavior/scroll_behavior.dart';
import 'package:family_budget/Icon/family_budget_icons_icons.dart';
import 'package:family_budget/Page/page_template.dart';
import 'package:family_budget/Widget/category_item.dart';
import 'package:family_budget/categories_list.dart';
import 'package:family_budget/category_controller.dart';
import 'package:family_budget/model/model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(child: SizedBox.expand(
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
          return ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: FutureBuilder(
                future: Future.wait(
                  [
                    CategoriesList.getCategoryBlocks(
                        1, constraints.maxWidth / 4, constraints.maxHeight / 4)
                  ],
                ),
                builder: (BuildContext context,
                    AsyncSnapshot<List<List<Widget>>> snapshot) {
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
                }),
          );
        },
      ),
    ));
  }
}
