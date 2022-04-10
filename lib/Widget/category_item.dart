import 'package:family_budget/Dialogs/unsaved_changes_dialog.dart';
import 'package:family_budget/currency_controller.dart';
import 'package:family_budget/model/model.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';

import 'calculator.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem(this.categoryId, this.type, this.text, this.height, this.width, this.color,
      this.iconData,
      {Key? key})
      : super(key: key);

  final double height;
  final double width;
  final String text;
  final Color color;
  final IconData iconData;
  final int categoryId;
  final int type;

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  Future<double> _getValue() async {
    double result = 0;

    List<Operation> operations = await Operation().select().user_id.equals(User.userID).and.type.equals(widget.type).and.category_id.equals(widget.categoryId).toList();

    for (var o in operations) {
      result += o.value!;
    }

    return result;
  }

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
              widget.text,
              style: const TextStyle(fontSize: 15),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            CircleAvatar(
              radius: 28,
              backgroundColor: widget.color.withAlpha(225),
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Calculator(widget.categoryId, widget.type);
                    },
                  ).whenComplete(() => setState(() {}));
                },
                icon: Icon(
                  widget.iconData,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 5),
            FutureBuilder(
              future: _getValue(),
              builder:
                  (BuildContext context, AsyncSnapshot<double> snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!.toStringAsFixed(0) + ' ' + CurrencyController.currency,
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    overflow: TextOverflow.ellipsis,);
                }
                return Text(
                  '0 ' + CurrencyController.currency,
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  overflow: TextOverflow.ellipsis,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}