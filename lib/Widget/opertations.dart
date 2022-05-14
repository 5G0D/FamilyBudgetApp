import 'package:family_budget/Model/model.dart';
import 'package:family_budget/category_item.dart';
import 'package:family_budget/currency_controller.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Operations extends StatefulWidget {
  const Operations(this.categoryItem, {Key? key}) : super(key: key);

  final CategoryItem categoryItem;

  @override
  _OperationsState createState() => _OperationsState();
}

class _OperationsState extends State<Operations> {
  Future<List<Operation>> _getOperations(int categoryId) async {
    return Operation()
        .select()
        .user_id
        .equals(User.params.user_id)
        .and
        .category_id
        .equals(categoryId)
        .and
        .status
        .not
        .equals(0)
        .orderByDesc("date")
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      color: const Color(0xff363645),
      child: Column(
        children: [
          Container(
            color: widget.categoryItem.color.withAlpha(180),
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.categoryItem.iconData),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.categoryItem.text,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            alignment: Alignment.center,
            child: FutureBuilder(
              future: CategoryItem.getValue(category_id: widget.categoryItem.categoryId),
              builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.categoryItem.type == 0)
                        const Text('Доходы',
                            style:
                                TextStyle(fontSize: 14, color: Colors.green)),
                      if (widget.categoryItem.type == 1)
                        const Text('Расходы',
                            style: TextStyle(fontSize: 14, color: Colors.red)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        snapshot.data!.toStringAsFixed(0) +
                            " " +
                            CurrencyController.currency,
                        style: TextStyle(
                          fontSize: 23,
                          color: widget.categoryItem.type == 0
                              ? Colors.green
                              : Colors.red,
                        ),
                        softWrap: false,
                      ),
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.grey[800]!, width: 1))),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getOperations(widget.categoryItem.categoryId),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Operation>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final item = snapshot.data![index];
                          return Dismissible(
                            key: Key(item.id!.toString()),
                            onDismissed: (direction) async {
                              item.status = 0;
                              await item.save();
                              setState(() {
                                snapshot.data!.remove(item);
                              });
                            },
                            background:
                                Container(color: Colors.red.withAlpha(10)),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[800]!, width: 1))),
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.description!.isEmpty
                                                ? 'Без описания'
                                                : item.description!,
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                          ),
                                          Text(
                                            DateFormat('yyyy.MM.dd hh:mm')
                                                .format(
                                              DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      item.date!),
                                            ),
                                            style: TextStyle(
                                              color: Colors.grey[500]!,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          (widget.categoryItem.type == 0
                                                  ? "+"
                                                  : "-") +
                                              item.value!.toStringAsFixed(0),
                                          softWrap: false,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              color:
                                                  widget.categoryItem.type == 0
                                                      ? Colors.green
                                                      : Colors.red,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }
                }

                return const Center(
                    child: Text(
                  "Операции отсутствуют",
                  style: TextStyle(fontSize: 16),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
