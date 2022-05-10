extension StringPlus on String{
  String removeSpaces() => replaceAll(' ', '');

  bool get isNumeric => double.tryParse(this) != null;
}