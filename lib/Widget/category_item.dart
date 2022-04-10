import 'package:family_budget/Dialogs/unsaved_changes_dialog.dart';
import 'package:family_budget/currency_controller.dart';
import 'package:flutter/material.dart';

import 'calculator.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem(this.text, this.amount, this.height, this.width, this.color,
      this.iconData,
      {Key? key})
      : super(key: key);

  double height;
  double width;
  String text;
  double amount;
  Color color;
  IconData iconData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 15),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            CircleAvatar(
              radius: 28,
              backgroundColor: color.withAlpha(225),
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return const Calculator();
                    },
                  );
                },
                icon: Icon(
                  iconData,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              amount.toStringAsFixed(0) + ' ' + CurrencyController.currency,
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
