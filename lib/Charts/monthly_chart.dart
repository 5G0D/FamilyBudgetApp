import 'package:charts_flutter/flutter.dart' as charts;
import 'package:family_budget/Extansions/hex_color.dart';
import 'package:family_budget/Extansions/operation_plus.dart';
import 'package:family_budget/currency_controller.dart';
import 'package:family_budget/date_picker_controller.dart';
import 'package:family_budget/model/model.dart';
import 'package:family_budget/operations_chart_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../user.dart';

class MonthlyChart extends StatefulWidget {
  const MonthlyChart({Key? key}) : super(key: key);

  @override
  _MonthlyChartState createState() => _MonthlyChartState();
}

class _MonthlyChartState extends State<MonthlyChart> {
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
        builder: (builder, AsyncSnapshot<dynamic> snapshot) {
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
                      child: charts.LineChart(
                        snapshot.data!,
                        defaultRenderer: charts.LineRendererConfig(
                            includeArea: true, stacked: false),
                        animate: false,
                        animationDuration: const Duration(milliseconds: 300),
                        defaultInteractions: false,
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
                        primaryMeasureAxis: charts.NumericAxisSpec(
                          renderSpec: const charts.GridlineRendererSpec(
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
                          }),
                        ),
                        domainAxis: charts.AxisSpec<num>(
                          renderSpec: const charts.GridlineRendererSpec(
                            minimumPaddingBetweenLabelsPx: 5,
                            labelRotation: 45,
                            lineStyle: charts.LineStyleSpec(
                              color: charts.MaterialPalette.transparent,
                            ),
                            labelStyle: charts.TextStyleSpec(
                                fontSize: 14,
                                color: charts.MaterialPalette.white),
                          ),
                          tickFormatterSpec:
                              charts.BasicNumericTickFormatterSpec(
                                  (num? value) {
                            if ((value ?? 0) == 0) {
                              return '';
                            } else {
                              return DateFormat('dd.MM').format(DateTime(
                                  DatePickerController.date.year,
                                  DatePickerController.date.month,
                                  value!.toInt()));
                            }
                          }),
                        ),
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

  Future<List<charts.Series<OperationsChartItem, num>>> _createData() async {
    isLoading = true;
    dataNotFound = true;

    List<RoomMember> roomMembers =
        await RoomMember().select().status.not.equals(0).toList();

    List<charts.Series<OperationsChartItem, num>> list = [];

    DateTime endDate = DatePickerController.date;
    if (endDate.year == DateTime.now().year &&
        endDate.month == DateTime.now().month) {
      endDate = endDate.add(const Duration(days: 1));
    } else {
      endDate = DateTime(endDate.year, endDate.month + 1, 0);
    }

    for (var m in roomMembers) {
      List<OperationsChartItem> operationsItems = [];

      DateTime startDate = DateTime(
          DatePickerController.date.year, DatePickerController.date.month);

      double value = 0;

      while (startDate.isBefore(endDate)) {
        OperationsChartItem item = OperationsChartItem(day: startDate.day);
        value += await Operation().getValueByDate(m.user_id!, _currentType,
            startDate, startDate.add(const Duration(days: 1)));
        item.Value = value;
        operationsItems.add(item);
        startDate = startDate.add(const Duration(days: 1));
      }

      if (value > 0) {
        dataNotFound = false;
      }

      list.add(
        charts.Series<OperationsChartItem, num>(
          id: m.user_id!.toString(),
          displayName: m.user_name,
          colorFn: (_, __) =>
              charts.Color.fromHex(code: (Color(m.user_color!).toHex())),
          domainFn: (OperationsChartItem item, _) => item.day,
          measureFn: (OperationsChartItem item, _) => item.value,
          data: operationsItems,
        ),
      );
    }

    isLoading = false;
    return list;
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
