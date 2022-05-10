import 'package:family_budget/Dialogs/unsaved_changes_dialog.dart';
import 'package:family_budget/category_item.dart';
import 'package:family_budget/currency_controller.dart';
import 'package:family_budget/date_picker_controller.dart';
import 'package:family_budget/model/model.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';

import 'calculator.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget(this.categoryItem, this.width, this.height, this.refresh,
      {Key? key})
      : super(key: key);

  final CategoryItem categoryItem;
  final double height;
  final double width;
  final Function() refresh;

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.categoryItem.text,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            CircleAvatar(
              radius: 24,
              backgroundColor: widget.categoryItem.color.withAlpha(225),
              child: IconButton(
                onPressed: () {
                  if (DatePickerController.date ==
                      DateTime(DateTime.now().year, DateTime.now().month,
                          DateTime.now().day)) {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          child: Calculator(
                            widget.categoryItem,
                          ),
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                        );
                      },
                      isScrollControlled: true,
                    ).whenComplete(() => widget.refresh());
                  }
                },
                icon: Icon(
                  widget.categoryItem.iconData,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.categoryItem.value.toStringAsFixed(0) +
                  ' ' +
                  CurrencyController.currency,
              style: TextStyle(fontSize: 13, color: widget.categoryItem.value > 0 ? widget.categoryItem.color : Colors.grey[500]),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
