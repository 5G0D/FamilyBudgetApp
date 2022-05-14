import 'package:family_budget/Page/page_template.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  void _refresh(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(child: Text('chat'), refreshFunc: _refresh, datePickerEnable: false,);
  }
}