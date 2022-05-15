import 'package:flutter/material.dart';

import '../Model/model.dart';
import '../user.dart';

class ChatMessageSender extends StatefulWidget {
  const ChatMessageSender(
      {required this.roomId, required this.refresh, Key? key})
      : super(key: key);

  final int roomId;
  final Function refresh;

  @override
  _ChatMessageSenderState createState() => _ChatMessageSenderState();
}

class _ChatMessageSenderState extends State<ChatMessageSender> {
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff313140),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff363645),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                    ],
                ),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(12),
                    hintText: ('Введите сообщение'),
                    hintStyle: TextStyle(color: Colors.grey[600]!,),
                  ),
                  controller: _messageController,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(7),
            child: InkWell(
              onTap: () async {
                if (_messageController.text.isNotEmpty) {
                  await Chat.withFields(
                          1,
                          DateTime.now().millisecondsSinceEpoch,
                          widget.roomId,
                          User.params.user_id,
                          _messageController.text,
                          DateTime.now().millisecondsSinceEpoch,
                          2)
                      .save();
                }

                widget.refresh();
                _messageController.text = '';
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: ClipOval(
                child: Container(
                  width: 48,
                  height: 48,
                  padding: const EdgeInsets.only(left: 2),
                  color: const Color(0xff5537a1),
                  child: const Icon(
                    Icons.send,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      padding: EdgeInsets.only(
          bottom: (MediaQuery.of(context).viewInsets.bottom - 56 > 0)
              ? MediaQuery.of(context).viewInsets.bottom - 56
              : 0),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
