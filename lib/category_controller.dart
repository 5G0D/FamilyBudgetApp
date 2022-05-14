import 'package:family_budget/Icon/family_budget_icons_icons.dart';
import 'package:family_budget/Widget/category_widget.dart';
import 'package:family_budget/model/model.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryController {
  static newCategoriesInit(int id, int offset) async {
    List<Category> categories = [];
    categories.add(Category.withFields(
        1,
        DateTime.now().millisecondsSinceEpoch,
        20*offset + 1,
        id,
        'Досуг',
        FamilyBudgetIcons.weekend.codePoint,
        Colors.blue.value,
        1,
        1,
        1));
    categories.add(Category.withFields(
        1,
        DateTime.now().millisecondsSinceEpoch,
        20*offset + 2,
        id,
        'Еда',
        FamilyBudgetIcons.food.codePoint,
        Colors.yellow.value,
        1,
        2,
        1));
    categories.add(Category.withFields(
        1,
        DateTime.now().millisecondsSinceEpoch,
        20*offset + 3,
        id,
        'Жилье',
        FamilyBudgetIcons.home.codePoint,
        Colors.green.value,
        1,
        3,
        1));
    categories.add(Category.withFields(
        1,
        DateTime.now().millisecondsSinceEpoch,
        20*offset + 4,
            id,
        'Гигиена',
        FamilyBudgetIcons.pump_soap.codePoint,
        Colors.purple.value,
        1,
        4,
        1));
    categories.add(Category.withFields(
        1,
        DateTime.now().millisecondsSinceEpoch,
        20*offset + 5,
            id,
        'Питомцы',
        FamilyBudgetIcons.cat.codePoint,
        Colors.deepOrange.value,
        2,
        1,
        1));
    categories.add(Category.withFields(
        1,
        DateTime.now().millisecondsSinceEpoch,
        20*offset + 6,
            id,
        'Одежда',
        FamilyBudgetIcons.t_shirt.codePoint,
        Colors.deepPurpleAccent.value,
        2,
        2,
        1));
    categories.add(Category.withFields(
        1,
        DateTime.now().millisecondsSinceEpoch,
        20*offset + 7,
            id,
        'Транспорт',
        FamilyBudgetIcons.car.codePoint,
        Colors.orange.value,
        3,
        1,
        1));
    categories.add(Category.withFields(
        1,
        DateTime.now().millisecondsSinceEpoch,
        20*offset + 8,
            id,
        'Здоровье',
        FamilyBudgetIcons.healing.codePoint,
        Colors.red.value,
        3,
        2,
        1));
    categories.add(Category.withFields(
        1,
        DateTime.now().millisecondsSinceEpoch,
        20*offset + 9,
            id,
        'Подписки',
        FamilyBudgetIcons.subscriptions.codePoint,
        Colors.lightBlueAccent.value,
        4,
        1,
        1));
    categories.add(Category.withFields(
        1,
        DateTime.now().millisecondsSinceEpoch,
        20*offset + 10,
            id,
        'Подарки',
        FamilyBudgetIcons.gift_1.codePoint,
        Colors.redAccent.value,
        4,
        2,
        1));
    categories.add(Category.withFields(
        1,
        DateTime.now().millisecondsSinceEpoch,
        20*offset + 11,
            id,
        'Хобби',
        FamilyBudgetIcons.grade.codePoint,
        Colors.lightGreenAccent.value,
        4,
        3,
        1));
    categories.add(Category.withFields(
        1,
        DateTime.now().millisecondsSinceEpoch,
        20*offset + 12,
            id,
        'Другое',
        FamilyBudgetIcons.inbox.codePoint,
        Colors.grey.value,
        4,
        4,
        1));

    categories.add(Category.withFields(
        1,
        DateTime.now().millisecondsSinceEpoch,
        20*offset + 13,
            id,
        'Зарплата',
        FamilyBudgetIcons.briefcase.codePoint,
        Colors.cyanAccent[700]!.value,
        1,
        1,
        0));
    categories.add(Category.withFields(
        1,
        DateTime.now().millisecondsSinceEpoch,
        20*offset + 14,
            id,
        'Вклады',
        FamilyBudgetIcons.university.codePoint,
        Colors.purple[400]!.value,
        1,
        2,
        0));
    categories.add(Category.withFields(
        1,
        DateTime.now().millisecondsSinceEpoch,
        20*offset + 15,
            id,
        'Инвестиции',
        FamilyBudgetIcons.suitcase.codePoint,
        Colors.greenAccent[700]!.value,
        1,
        3,
        0));
    categories.add(Category.withFields(
        1,
        DateTime.now().millisecondsSinceEpoch,
        20*offset + 16,
            id,
        'Стипендия',
        FamilyBudgetIcons.award.codePoint,
        Colors.lightBlueAccent.value,
        1,
        4,
        0));
    categories.add(Category.withFields(
        1,
        DateTime.now().millisecondsSinceEpoch,
        20*offset + 17,
            id,
        'Долги',
        FamilyBudgetIcons.wallet.codePoint,
        Colors.limeAccent[700]!.value,
        2,
        1,
        0));
    categories.add(Category.withFields(
        1,
        DateTime.now().millisecondsSinceEpoch,
        (20*offset + 18).toInt(),
            id,
        'Пособия',
        FamilyBudgetIcons.child.codePoint,
        Colors.teal.value,
        3,
        1,
        0));

    await Category.saveAll(categories);

  }
}
