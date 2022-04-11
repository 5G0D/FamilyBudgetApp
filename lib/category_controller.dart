import 'package:family_budget/Icon/family_budget_icons_icons.dart';
import 'package:family_budget/Widget/category_widget.dart';
import 'package:family_budget/model/model.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryController {
  static int _categoriesType = 1;

  static int get currentType => _categoriesType;

  static void changeCurrentType(){
    _categoriesType = _categoriesType == 0 ? 1 : 0;
  }

  static _newCategoriesInit() async {
    List<Category> categories = [];
    categories.add(Category.withFields(1, DateTime.now().millisecondsSinceEpoch, User.userID, 'Досуг', FamilyBudgetIcons.weekend.codePoint, Colors.blue.value, 1, 1, 1));
    categories.add(Category.withFields(1, DateTime.now().millisecondsSinceEpoch, User.userID, 'Еда', FamilyBudgetIcons.food.codePoint, Colors.yellow.value, 1, 2, 1));
    categories.add(Category.withFields(1, DateTime.now().millisecondsSinceEpoch, User.userID, 'Жилье', FamilyBudgetIcons.home.codePoint, Colors.green.value, 1, 3, 1));
    categories.add(Category.withFields(1, DateTime.now().millisecondsSinceEpoch, User.userID, 'Гигиена', FamilyBudgetIcons.pump_soap.codePoint, Colors.purple.value, 1, 4, 1));
    categories.add(Category.withFields(1, DateTime.now().millisecondsSinceEpoch, User.userID, 'Питомцы', FamilyBudgetIcons.cat.codePoint, Colors.deepOrange.value, 2, 1, 1));
    categories.add(Category.withFields(1, DateTime.now().millisecondsSinceEpoch, User.userID, 'Одежда', FamilyBudgetIcons.t_shirt.codePoint, Colors.deepPurpleAccent.value, 2, 2, 1));
    categories.add(Category.withFields(1, DateTime.now().millisecondsSinceEpoch, User.userID, 'Транспорт', FamilyBudgetIcons.car.codePoint, Colors.orange.value, 3, 1, 1));
    categories.add(Category.withFields(1, DateTime.now().millisecondsSinceEpoch, User.userID, 'Здоровье', FamilyBudgetIcons.healing.codePoint, Colors.red.value, 3, 2, 1));
    categories.add(Category.withFields(1, DateTime.now().millisecondsSinceEpoch, User.userID, 'Подписки', FamilyBudgetIcons.subscriptions.codePoint, Colors.lightBlueAccent.value, 4, 1, 1));
    categories.add(Category.withFields(1, DateTime.now().millisecondsSinceEpoch, User.userID, 'Подарки', FamilyBudgetIcons.gift_1.codePoint, Colors.redAccent.value, 4, 2, 1));
    categories.add(Category.withFields(1, DateTime.now().millisecondsSinceEpoch, User.userID, 'Хобби', FamilyBudgetIcons.grade.codePoint, Colors.lightGreenAccent.value, 4, 3, 1));
    categories.add(Category.withFields(1, DateTime.now().millisecondsSinceEpoch, User.userID, 'Другое', FamilyBudgetIcons.inbox.codePoint, Colors.grey.value, 4, 4, 1));
    await Category.saveAll(categories);
  }

  static categoriesInit() async {
    if ((await Category()
        .select()
        .user_id
        .equals(User.userID)
        .and
        .status
        .equals(1)
        .toList()).isEmpty){
      print('Категории не найдены');
      await _newCategoriesInit();
    }
  }
}
