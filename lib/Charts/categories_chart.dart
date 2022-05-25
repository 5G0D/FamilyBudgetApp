import 'package:charts_flutter/flutter.dart' as charts;
import 'package:family_budget/category_controller.dart';
import 'package:family_budget/category_item.dart';
import 'package:family_budget/currency_controller.dart';
import 'package:family_budget/extansions/hex_color.dart';
import 'package:family_budget/model/model.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';
import 'package:charts_common/src/common/color.dart' as charts_color;

class CategoriesChart extends StatelessWidget {
  final List<charts.Series<dynamic, int>> seriesList;
  final bool animate;
  final double valueSum;
  final int type;
  final double height;
  final int userId;

  const CategoriesChart(this.seriesList,
      {required this.animate,
      required this.valueSum,
      required this.type,
      required this.height,
      required this.userId,
      Key? key})
      : super(key: key);

  factory CategoriesChart.withCategoryItems(
    List<CategoryItem> categoryItems,
    double valueSum,
    int type,
    double height,
    int userId,
  ) {
    return CategoriesChart(
      [
        charts.Series<CategoryItem, int>(
          id: 'Sales',
          domainFn: (CategoryItem item, _) => item.categoryId,
          measureFn: (CategoryItem item, _) => item.value,
          colorFn: (CategoryItem item, _) =>
              charts_color.Color.fromHex(code: (item.color.toHex())),
          data: categoryItems,
        )
      ],
      animate: true,
      valueSum: valueSum,
      type: type,
      height: height,
      userId: userId,
    );
  }

  factory CategoriesChart.withEmptySeries(int type, double height, int userId) {
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
      type: type,
      height: height,
      userId: userId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: height / 20),
          height: height / 10,
          alignment: Alignment.center,
          child: FutureBuilder(
            future: Future.wait([
              RoomMember()
                  .select()
                  .user_id
                  .equals(userId)
                  .and
                  .status
                  .not
                  .equals(0)
                  .toList(),
            ]),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                List<RoomMember> members = snapshot.data[0];
                if (members.isNotEmpty) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        members.first.user_name!,
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(members.first.user_color!),
                            fontWeight: FontWeight.bold),
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                      if (members.first.user_id! == User.params.user_id!)
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ),
                    ],
                  );
                }
              }
              return const SizedBox();
            },
          ),
        ),
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
                Text(type == 0 ? 'Доходы' : 'Расходы',
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  valueSum.toStringAsFixed(0) +
                      ' ' +
                      CurrencyController.currency,
                  style:
                      TextStyle(color: (type == 0 ? Colors.green : Colors.red)),
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
