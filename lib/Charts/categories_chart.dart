import 'package:charts_flutter/flutter.dart' as charts;
import 'package:family_budget/category_controller.dart';
import 'package:family_budget/category_item.dart';
import 'package:family_budget/currency_controller.dart';
import 'package:family_budget/extansions/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:charts_common/src/common/color.dart' as charts_color;

class CategoriesChart extends StatelessWidget {
  final List<charts.Series<dynamic, int>> seriesList;
  final bool animate;
  final double valueSum;

  const CategoriesChart(this.seriesList,
      {required this.animate,
      required this.valueSum,
      Key? key})
      : super(key: key);

  factory CategoriesChart.withCategoryItems(
      List<CategoryItem> categoryItems, double valueSum) {
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
      valueSum: valueSum,
    );
  }

  factory CategoriesChart.withEmptySeries() {
    return CategoriesChart(
      [
        charts.Series<dynamic, int>(
          id: 'Sales',
          domainFn: (__, _) => 1,
          measureFn: (__, _) => 1,
          colorFn: (__, _) => charts.MaterialPalette.gray.shadeDefault,
          data: [0],
        )
      ],
      animate: false,
      valueSum: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        charts.PieChart<int>(
          seriesList,
          animate: animate,
          defaultRenderer: charts.ArcRendererConfig(
            arcWidth: 14,
            strokeWidthPx: 0,
          ),
          defaultInteractions: false,
        ),
        Center(
          child: SizedBox(
            height: 80,
            width: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(CategoryController.currentType == 0 ? 'Доходы' : 'Расходы',
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(
                  height: 8,
                ),
                Text(
                    valueSum.toStringAsFixed(0) +
                        ' ' +
                        CurrencyController.currency,
                    style: TextStyle(
                        color: (CategoryController.currentType == 0 ? Colors.green : Colors.red)), softWrap: false, overflow: TextOverflow.fade,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
