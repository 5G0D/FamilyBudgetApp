import 'package:charts_flutter/flutter.dart' as charts;
import 'package:family_budget/category_item.dart';
import 'package:family_budget/extansions/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:charts_common/src/common/color.dart' as charts_color;

class CategoriesChart extends StatelessWidget {
  final List<charts.Series<CategoryItem, int>> seriesList;
  final bool animate;

  const CategoriesChart(this.seriesList, {required this.animate, Key? key})
      : super(key: key);

  factory CategoriesChart.withCategoryItems(List<CategoryItem> categoryItems) {
    return CategoriesChart(
      [
        charts.Series<CategoryItem, int>(
          id: 'Sales',
          domainFn: (CategoryItem item, _) => item.id,
          measureFn: (CategoryItem item, _) => item.value,
          colorFn: (CategoryItem item, _) =>
              charts_color.Color.fromHex(code: (item.color.toHex())),
          data: categoryItems,
        )
      ],
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      charts.PieChart<int>(
        seriesList,
        animate: animate,
        defaultRenderer: charts.ArcRendererConfig(
          arcWidth: 14,
          strokeWidthPx: 0,
        ),
        defaultInteractions: false,
      ),
      const Center(child: Text('test')),
    ]);
  }
}
