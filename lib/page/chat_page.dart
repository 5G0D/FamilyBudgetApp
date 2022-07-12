import 'package:family_budget/Page/conversation_page.dart';
import 'package:family_budget/Page/page_template.dart';
import 'package:family_budget/model/controller/room.dart';
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
    return PageTemplate(child: ConversationPage(roomId: Room.params.room_id ?? 0,), refreshFunc: _refresh, datePickerEnable: false,);
  }
}