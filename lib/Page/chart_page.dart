import 'package:family_budget/Charts/monthly_chart.dart';
import 'package:family_budget/Charts/room_categories_chart.dart';
import 'package:family_budget/Page/page_template.dart';
import 'package:flutter/material.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final PageController pageController = PageController(initialPage: 999);

  void _refresh(){
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages= [
      RoomCategoriesChart(),
      MonthlyChart(),
    ];

    return PageTemplate(refreshFunc: _refresh, child: PageView.builder(
        itemBuilder: (context, index) {
      return pages[index % pages.length];
    },
    controller: pageController,
    ),
    );
  }
}
