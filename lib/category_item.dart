import 'package:family_budget/category_controller.dart';
import 'package:family_budget/date_picker_controller.dart';
import 'package:family_budget/model/model.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';

class CategoryItem {
  String text;
  Color color;
  IconData iconData;
  double value;
  int categoryId;
  int userId;
  int type;
  int id;
  int block;
  int position;

  CategoryItem({
    required this.id,
    required this.categoryId,
    required this.userId,
    required this.text,
    required this.type,
    required this.color,
    required this.iconData,
    required this.block,
    required this.position,
    this.value = 0,
  });

  static  Future<double> getValue({required int category_id}) async {
    double result = 0;

    List<Operation> operations = await Operation()
        .select()
        .category_id
        .equals(category_id)
        .and
        .status
        .not
        .equals(0)
        .toList();

    for (var o in operations) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(o.date!);
      if (date.year == DatePickerController.date.year &&
          date.month == DatePickerController.date.month) {
        result += o.value!;
      }
    }

    return result;
  }
}
