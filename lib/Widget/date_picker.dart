import 'package:family_budget/Widget/text_icon.dart';
import 'package:flutter/material.dart';

import '../date_picker_controller.dart';

class DatePicker extends StatefulWidget {
  const DatePicker(this.refresh, {Key? key}) : super(key: key);
  final Function() refresh;

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.chevron_left,
                      color: Colors.white, size: 30),
                  onPressed: () => setState(() {
                    DatePickerController.offSet = false;
                    widget.refresh();
                  }),
                  padding: const EdgeInsets.all(10),
                  splashRadius: 20,
                ),
              ),
              flex: 1),
          Expanded(
            child: Container(
              child: TextIcon(
                const Icon(Icons.calendar_today, size: 17),
                Text(
                  DatePickerController.formattedDate,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              alignment: Alignment.center,
            ),
            flex: 3,
          ),
          Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.chevron_right,
                      color: Colors.white, size: 30),
                  onPressed: () => setState(() {
                    DatePickerController.offSet = true;
                    widget.refresh();
                  }),
                  padding: const EdgeInsets.all(10),
                  splashRadius: 20,
                ),
              ),
              flex: 1),
        ],
      ),
    );
  }
}
