import 'package:charts_flutter/flutter.dart' as f;
import 'package:family_budget/category_chart_item.dart';
import 'package:family_budget/currency_controller.dart';
import 'package:family_budget/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:family_budget/extansions/hex_color.dart';

import '../category_item.dart';

class RoomCategoriesChart extends StatefulWidget {
  const RoomCategoriesChart({Key? key}) : super(key: key);

  @override
  _RoomCategoriesChartState createState() => _RoomCategoriesChartState();
}

class _RoomCategoriesChartState extends State<RoomCategoriesChart> {
  static int _currentType = 1;
  bool dataNotFound = true;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentType = _currentType == 1 ? 0 : 1;
        });
      },
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      hoverColor: Colors.red,
      child: FutureBuilder(
        future: _createData(),
        builder: (builder,
            AsyncSnapshot<List<charts.Series<CategoryChartItem, String>>>
                snapshot) {
          if (snapshot.hasData && !isLoading) {
            if (!dataNotFound) {
              return Column(
                children: [
                  Container(
                    height: 35,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _currentType == 1 ? "Расходы" : "Доходы",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                        Icon(
                          _currentType == 1
                              ? Icons.trending_down
                              : Icons.trending_up,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: _currentType == 1
                          ? Colors.red.withOpacity(0.9)
                          : Colors.green.withOpacity(0.9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: charts.BarChart(
                        snapshot.data!,
                        defaultInteractions: false,
                        animate: true,
                        animationDuration: const Duration(milliseconds: 200),
                        barGroupingType: charts.BarGroupingType.stacked,
                        vertical: false,
                        primaryMeasureAxis: charts.NumericAxisSpec(
                            renderSpec: const charts.GridlineRendererSpec(
                              minimumPaddingBetweenLabelsPx: 5,
                              lineStyle: charts.LineStyleSpec(
                                dashPattern: [6, 6],
                              ),
                              labelStyle: charts.TextStyleSpec(
                                  fontSize: 13,
                                  color: charts.MaterialPalette.white),
                            ),
                            tickFormatterSpec:
                                charts.BasicNumericTickFormatterSpec(
                                    (num? value) {
                              return (value ?? 0).toStringAsFixed(0) +
                                  ' ' +
                                  CurrencyController.currency;
                            })),
                        domainAxis: const charts.AxisSpec<String>(
                          renderSpec: charts.GridlineRendererSpec(
                            lineStyle: charts.LineStyleSpec(
                              color: charts.MaterialPalette.transparent,
                            ),
                            labelStyle: charts.TextStyleSpec(
                                fontSize: 14,
                                color: charts.MaterialPalette.white),
                          ),
                        ),
                        behaviors: [
                          charts.SeriesLegend(
                            position: charts.BehaviorPosition.bottom,
                            outsideJustification:
                                charts.OutsideJustification.startDrawArea,
                            horizontalFirst: true,
                            desiredMaxRows: 3,
                            cellPadding: const EdgeInsets.only(
                                right: 8, bottom: 8, top: 8),
                            entryTextStyle: const charts.TextStyleSpec(
                                color: charts.Color.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (dataNotFound) {
              return const Center(
                child: Text("Данные не найдены"),
              );
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<charts.Series<CategoryChartItem, String>>> _createData() async {
    isLoading = true;
    dataNotFound = true;

    List<RoomMember> roomMembers =
        await RoomMember().select().status.not.equals(0).toList();
    List<charts.Series<CategoryChartItem, String>> list = [];

    for (var m in roomMembers) {
      List<CategoryChartItem> categoryItems = [];

      for (var c in await Category()
          .select()
          .user_id
          .equals(m.user_id)
          .and
          .type
          .equals(_currentType)
          .and
          .status
          .not
          .equals(0)
          .toList()) {
        CategoryChartItem item =
            CategoryChartItem(categoryId: c.id!, categoryName: c.text!);

        double value = await CategoryItem.getValue(id: c.id!);

        item.Value = value;

        if (value > 0) {
          dataNotFound = false;
        }

        categoryItems.add(item);
      }

      list.add(
        charts.Series<CategoryChartItem, String>(
          id: m.user_id!.toString(),
          displayName: m.user_name,
          colorFn: (_, __) =>
              charts.Color.fromHex(code: (Color(m.user_color!).toHex())),
          domainFn: (CategoryChartItem item, _) => item.categoryName,
          measureFn: (CategoryChartItem item, _) => item.value,
          data: categoryItems,
        ),
      );
    }

    isLoading = false;
    return list;
  }
}
