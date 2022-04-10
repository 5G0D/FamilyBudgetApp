import 'package:family_budget/Dialogs/error_dialog.dart';
import 'package:family_budget/Widget/calculator_button.dart';
import 'package:family_budget/currency_controller.dart';
import 'package:family_budget/model/model.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator(this.categoryId, this.type, {Key? key}) : super(key: key);

  final int type;
  final int categoryId;

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final String _currency = CurrencyController.currency;
  String _calculateText = '0';

  String formatText(String text, {bool flag = true}) {
    String result;

    if (flag) {
      result = (text.endsWith(' ') ? text.substring(0, text.length - 3) : text)
          .replaceAll(',', '.')
          .replaceAll('÷', '/')
          .replaceAll('×', '*');
    } else {
      result = text.replaceAll('.', ',');
    }

    return result;
  }

  void _addNumber(int number) {
    setState(
      () {
        if (_calculateText.endsWith('0') && _calculateText.length == 1) {
          _calculateText =
              _calculateText.substring(0, _calculateText.length - 1);
        }
        _calculateText += number.toString();
      },
    );
  }

  void _addSymbol(String symbol) {
    setState(
      () {
        if (!_calculateText.endsWith(' ') &&
            _calculateText.isNotEmpty &&
            !_calculateText.contains(
                ',',
                _calculateText.lastIndexOf(' ') == -1
                    ? 0
                    : _calculateText.lastIndexOf(' '))) {
          _calculateText += symbol;
        }
      },
    );
  }

  void _addOperation(String operation) {
    setState(
      () {
        if (_calculateText.endsWith(' ')) {
          _calculateText =
              _calculateText.substring(0, _calculateText.length - 3);
        }
        if (!_calculateText.endsWith(' ') && _calculateText.isNotEmpty) {
          _calculateText += ' ' + operation + ' ';
        }
      },
    );
  }

  void _calculateString() {
    setState(
      () {
        String result;
        result = Parser()
            .parse(formatText(_calculateText))
            .evaluate(EvaluationType.REAL, ContextModel())
            .toStringAsFixed(1);

        if (result.endsWith('.0')) {
          result = result.substring(0, result.length - 2);
        }

        _calculateText = formatText(result, flag: false);
      },
    );
  }

  void _removeSymbol() {
    setState(
      () {
        if (_calculateText.isNotEmpty) {
          if (_calculateText.endsWith(' ')) {
            _calculateText =
                _calculateText.substring(0, _calculateText.length - 3);
          } else {
            _calculateText =
                _calculateText.substring(0, _calculateText.length - 1);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_calculateText.isEmpty) {
      _calculateText = '0';
    }

    return Container(
        height: 310,
        color: const Color(0xff363645),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.symmetric(
                    horizontal:
                        BorderSide(width: 1.0, color: Colors.grey[700]!)),
              ),
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Text(
                  _calculateText + ' ' + _currency,
                  style: const TextStyle(fontSize: 25),
                  softWrap: false,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      CalculatorButton(
                        child: const Text(
                          '÷',
                          style: TextStyle(fontSize: 25),
                        ),
                        border: Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.grey[700]!,
                          ),
                          bottom:
                              BorderSide(width: 1.0, color: Colors.grey[700]!),
                        ),
                        color: const Color(0xff383847),
                        onPressed: () => {_addOperation('÷')},
                      ),
                      CalculatorButton(
                        child: const Text(
                          '×',
                          style: TextStyle(fontSize: 25),
                        ),
                        border: Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.grey[700]!,
                          ),
                          bottom:
                              BorderSide(width: 1.0, color: Colors.grey[700]!),
                        ),
                        color: const Color(0xff383847),
                        onPressed: () => {_addOperation('×')},
                      ),
                      CalculatorButton(
                        child: const Text(
                          '-',
                          style: TextStyle(fontSize: 25),
                        ),
                        border: Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.grey[700]!,
                          ),
                          bottom:
                              BorderSide(width: 1.0, color: Colors.grey[700]!),
                        ),
                        color: const Color(0xff383847),
                        onPressed: () => {_addOperation('-')},
                      ),
                      CalculatorButton(
                        child: const Text(
                          '+',
                          style: TextStyle(fontSize: 25),
                        ),
                        border: Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.grey[700]!,
                          ),
                          bottom:
                              BorderSide(width: 1.0, color: Colors.grey[700]!),
                        ),
                        color: const Color(0xff383847),
                        onPressed: () => {_addOperation('+')},
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      CalculatorButton(
                        child: const Text(
                          '7',
                          style: TextStyle(fontSize: 25),
                        ),
                        border: Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.grey[700]!,
                          ),
                          bottom:
                              BorderSide(width: 1.0, color: Colors.grey[700]!),
                        ),
                        color: const Color(0xff363645),
                        onPressed: () => {_addNumber(7)},
                      ),
                      CalculatorButton(
                        child: const Text(
                          '4',
                          style: TextStyle(fontSize: 25),
                        ),
                        border: Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.grey[700]!,
                          ),
                          bottom:
                              BorderSide(width: 1.0, color: Colors.grey[700]!),
                        ),
                        color: const Color(0xff363645),
                        onPressed: () => {_addNumber(4)},
                      ),
                      CalculatorButton(
                        child: const Text(
                          '1',
                          style: TextStyle(fontSize: 25),
                        ),
                        border: Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.grey[700]!,
                          ),
                          bottom:
                              BorderSide(width: 1.0, color: Colors.grey[700]!),
                        ),
                        color: const Color(0xff363645),
                        onPressed: () => {_addNumber(1)},
                      ),
                      CalculatorButton(
                        child: Text(
                          _currency,
                          style: const TextStyle(fontSize: 25),
                        ),
                        border: Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.grey[700]!,
                          ),
                          bottom:
                              BorderSide(width: 1.0, color: Colors.grey[700]!),
                        ),
                        color: const Color(0xff363645),
                        onPressed: () => {},
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      CalculatorButton(
                        child: const Text(
                          '8',
                          style: TextStyle(fontSize: 25),
                        ),
                        border: Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.grey[700]!,
                          ),
                          bottom:
                              BorderSide(width: 1.0, color: Colors.grey[700]!),
                        ),
                        color: const Color(0xff363645),
                        onPressed: () => {_addNumber(8)},
                      ),
                      CalculatorButton(
                        child: const Text(
                          '5',
                          style: TextStyle(fontSize: 25),
                        ),
                        border: Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.grey[700]!,
                          ),
                          bottom:
                              BorderSide(width: 1.0, color: Colors.grey[700]!),
                        ),
                        color: const Color(0xff363645),
                        onPressed: () => {_addNumber(5)},
                      ),
                      CalculatorButton(
                        child: const Text(
                          '2',
                          style: TextStyle(fontSize: 25),
                        ),
                        border: Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.grey[700]!,
                          ),
                          bottom:
                              BorderSide(width: 1.0, color: Colors.grey[700]!),
                        ),
                        color: const Color(0xff363645),
                        onPressed: () => {_addNumber(2)},
                      ),
                      CalculatorButton(
                        child: const Text(
                          '0',
                          style: TextStyle(fontSize: 25),
                        ),
                        border: Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.grey[700]!,
                          ),
                          bottom:
                              BorderSide(width: 1.0, color: Colors.grey[700]!),
                        ),
                        color: const Color(0xff363645),
                        onPressed: () => {_addNumber(0)},
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      CalculatorButton(
                        child: const Text(
                          '9',
                          style: TextStyle(fontSize: 25),
                        ),
                        border: Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.grey[700]!,
                          ),
                          bottom:
                              BorderSide(width: 1.0, color: Colors.grey[700]!),
                        ),
                        color: const Color(0xff363645),
                        onPressed: () => {_addNumber(9)},
                      ),
                      CalculatorButton(
                        child: const Text(
                          '6',
                          style: TextStyle(fontSize: 25),
                        ),
                        border: Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.grey[700]!,
                          ),
                          bottom:
                              BorderSide(width: 1.0, color: Colors.grey[700]!),
                        ),
                        color: const Color(0xff363645),
                        onPressed: () => {_addNumber(6)},
                      ),
                      CalculatorButton(
                        child: const Text(
                          '3',
                          style: TextStyle(fontSize: 25),
                        ),
                        border: Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.grey[700]!,
                          ),
                          bottom:
                              BorderSide(width: 1.0, color: Colors.grey[700]!),
                        ),
                        color: const Color(0xff363645),
                        onPressed: () => {_addNumber(3)},
                      ),
                      CalculatorButton(
                        child: const Text(
                          ',',
                          style: TextStyle(fontSize: 25),
                        ),
                        border: Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.grey[700]!,
                          ),
                          bottom:
                              BorderSide(width: 1.0, color: Colors.grey[700]!),
                        ),
                        color: const Color(0xff363645),
                        onPressed: () => {_addSymbol(',')},
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      CalculatorButton(
                        child: const Icon(Icons.backspace),
                        border: Border(
                          bottom:
                              BorderSide(width: 1.0, color: Colors.grey[700]!),
                        ),
                        color: const Color(0xff383847),
                        onPressed: () => {_removeSymbol()},
                      ),
                      if (double.tryParse(formatText(_calculateText)) != null)
                        CalculatorButton(
                          child: const Icon(Icons.done),
                          border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: Colors.grey[700]!),
                          ),
                          color: Colors.green[600]!.withAlpha(210),
                          onPressed: () => {
                            if (double.parse(formatText(_calculateText)) < 0)
                              {
                                errorDialog(
                                  context,
                                  'Результат не может быть меньше нуля',
                                )
                              }
                            else
                              {
                                Operation.withFields(1, DateTime.now().millisecondsSinceEpoch, widget.type, User.userID, widget.categoryId, DateTime.now().millisecondsSinceEpoch, 'test', double.parse(formatText(_calculateText))).save(),
                                Navigator.pop(context)
                              }
                          },
                          height: 180,
                        ),
                      if (double.tryParse(formatText(_calculateText)) == null)
                        CalculatorButton(
                          child: const Text(
                            '=',
                            style: TextStyle(fontSize: 35),
                          ),
                          border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: Colors.grey[700]!),
                          ),
                          color: Colors.yellow[600]!.withAlpha(210),
                          onPressed: () => {_calculateString()},
                          height: 180,
                        ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}