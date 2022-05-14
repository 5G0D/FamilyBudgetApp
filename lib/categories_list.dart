import 'package:family_budget/Charts/categories_chart.dart';
import 'package:family_budget/Widget/category_widget.dart';
import 'package:family_budget/category_controller.dart';
import 'package:family_budget/category_item.dart';
import 'package:family_budget/model/model.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';

class CategoriesList {
  static Future<List<Widget>> getCategoryBlocks(
    int userId,
    double itemWidth,
    double itemHeight,
    int currentType,
    Function() refresh,
    Function() changeCurrentType,
  ) async {
    List<CategoryItem> categories = [];
    double valueSum = 0;

    for (var c in (await Category()
        .select()
        .user_id
        .equals(userId)
        .and
        .status
        .equals(1)
        .and
        .type
        .equals(currentType)
        .orderBy("block")
        .orderBy("position")
        .toList())) {
      double value = await CategoryItem.getValue(category_id: c.category_id!);
      valueSum += value;

      categories.add(
        CategoryItem(
            id: c.id!,
            categoryId: c.category_id!,
            userId: userId,
            text: c.text!,
            type: c.type!,
            color: Color(c.icon_color!),
            iconData: IconData(c.icon_code!, fontFamily: 'FamilyBudgetIcons'),
            block: c.block!,
            position: c.position!,
            value: value),
      );
    }

    List<Widget> resultList = [];
    List<Widget> rowList = [];

    //1 Блок
    resultList.add(Row(
        children:
            getFilledBlock(categories, 4, 1, itemHeight, itemWidth, refresh)));

    //2 Блок
    rowList.add(Column(
        children:
            getFilledBlock(categories, 2, 2, itemHeight, itemWidth, refresh)));

    //Блок (чарт)
    rowList.add(
      SizedBox(
        width: itemWidth * 2,
        height: itemHeight * 2,
        child: InkWell(
          onTap: () {
            changeCurrentType();
            refresh();
          },
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          child: (valueSum > 0
              ? CategoriesChart.withCategoryItems(categories, valueSum, currentType, itemHeight * 2, userId)
              : CategoriesChart.withEmptySeries(currentType, itemHeight * 2, userId)),
        ),
      ),
    );

    //3 Блок
    rowList.add(Column(
        children:
            getFilledBlock(categories, 2, 3, itemHeight, itemWidth, refresh)));

    // Добавляем 2 3 блоки и чарт в ряд
    resultList.add(Row(
      children: rowList,
    ));

    //4 Блок (бесконечный)
    resultList.add(Wrap(
        children: getWrapBlock(categories, 4, itemHeight, itemWidth, refresh)));

    return resultList;
  }

  static List<Widget> getFilledBlock(
      List<CategoryItem> categories,
      int itemCount,
      int blockNum,
      double itemHeight,
      double itemWidth,
      Function() refresh) {
    List<Widget> blockList = [];
    for (int i = 1; i <= itemCount; i++) {
      Iterable<CategoryItem> categoryIter =
          categories.where((e) => e.block == blockNum && e.position == i);
      if (categoryIter.isNotEmpty) {
        blockList.add(
          CategoryWidget(
            categoryIter.first,
            itemWidth,
            itemHeight,
            refresh,
          ),
        );
      } else {
        blockList.add(
          SizedBox(
            width: itemWidth,
            height: itemHeight,
          ),
        );
      }
    }

    return blockList;
  }

  static List<Widget> getWrapBlock(List<CategoryItem> categories, int blockNum,
      double itemHeight, double itemWidth, Function() refresh) {
    List<Widget> blockList = [];
    int blockPos = 1;

    categories.where((e) => e.block == blockNum).forEach((e) {
      while (blockPos < (e.position)) {
        blockList.add(
          SizedBox(
            width: itemWidth,
            height: itemHeight,
          ),
        );
        blockPos++;
      }

      blockList.add(CategoryWidget(
        e,
        itemWidth,
        itemHeight,
        refresh,
      ));
      blockPos++;
    });

    return blockList;
  }
}
