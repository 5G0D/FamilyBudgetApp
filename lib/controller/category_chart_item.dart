class CategoryChartItem{
  int categoryId;
  String categoryName;
  late double value;

  set Value(double value) => this.value = value;

  CategoryChartItem({required this.categoryId, required this.categoryName});

}