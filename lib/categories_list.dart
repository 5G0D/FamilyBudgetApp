import 'package:family_budget/Widget/category_item.dart';
import 'package:family_budget/model/model.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';

class CategoriesList {
  static Future<List<Widget>> getCategoryBlocks(
      int type, double itemWidth, double itemHeight) async {
    List<Category> categories = await Category()
        .select()
        .user_id
        .equals(User.userID)
        .and
        .status
        .equals(1)
        .and
        .type
        .equals(type)
        .orderBy("block")
        .orderBy("position")
        .toList();

    List<Widget> resultList = [];
    List<Widget> rowList = [];

    //1 Блок
    resultList.add(
        Row(children: getFilledBlock(categories, 4, 1, itemHeight, itemWidth)));

    //2 Блок
    rowList.add(Column(
        children: getFilledBlock(categories, 2, 2, itemHeight, itemWidth)));

    //Блок (чарт)
    rowList.add(SizedBox(
      width: itemWidth * 2,
      height: itemHeight * 2,
    ));

    //3 Блок
    rowList.add(Column(
        children: getFilledBlock(categories, 2, 3, itemHeight, itemWidth)));

    // Добавляем 2 3 блоки и чарт в ряд
    resultList.add(Row(
      children: rowList,
    ));

    //4 Блок (бесконечный)
    resultList.add(
        Wrap(children: getWrapBlock(categories, 4, itemHeight, itemWidth)));

    return resultList;
  }

  static List<Widget> getFilledBlock(List<Category> categories, int itemCount,
      int blockNum, double itemHeight, double itemWidth) {
    List<Widget> blockList = [];
    for (int i = 1; i <= itemCount; i++) {
      Iterable<Category> categoryIter =
          categories.where((e) => e.block == blockNum && e.position! == i);
      if (categoryIter.isNotEmpty) {
        blockList.add(CategoryItem(
            categoryIter.first.id!,
            0,
            categoryIter.first.text ?? '',
            itemHeight,
            itemWidth,
            Color(categoryIter.first.icon_color ?? Colors.blue.value),
            IconData(categoryIter.first.icon_code!,
                fontFamily: 'FamilyBudgetIcons')));
      } else {
        blockList.add(SizedBox(
          width: itemWidth,
          height: itemHeight,
        ));
      }
    }

    return blockList;
  }

  static List<Widget> getWrapBlock(List<Category> categories, int blockNum,
      double itemHeight, double itemWidth) {
    List<Widget> blockList = [];
    int blockPos = 1;

    categories.where((e) => e.block == blockNum).forEach((e) {
      while (blockPos < (e.position ?? blockPos)) {
        blockList.add(SizedBox(
          width: itemWidth,
          height: itemHeight,
        ));
        blockPos++;
      }

      blockList.add(CategoryItem(
          e.id!,
          0,
          e.text ?? '',
          itemHeight,
          itemWidth,
          Color(e.icon_color ?? Colors.blue.value),
          IconData(e.icon_code!, fontFamily: 'FamilyBudgetIcons')));
      blockPos++;
    });

    return blockList;
  }
}
