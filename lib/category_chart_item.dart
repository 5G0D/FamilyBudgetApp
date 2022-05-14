import 'package:family_budget/category_item.dart';
import 'package:family_budget/model/model.dart';

class CategoryChartItem{
  int categoryId;
  String categoryName;
  late double value;

  set Value(double value) => this.value = value;

  CategoryChartItem({required this.categoryId, required this.categoryName});

}