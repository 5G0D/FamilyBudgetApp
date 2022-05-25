import 'package:family_budget/Server/chat_socket.dart';
import 'package:family_budget/Widget/chat_message.dart';
import 'package:family_budget/Widget/chat_message_sender.dart';
import 'package:family_budget/room.dart';
import 'package:flutter/material.dart';
import 'package:family_budget/extansions/chat_utils.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:family_budget/extansions/date_format_utils.dart';
import 'package:signalr_netcore/hub_connection.dart';

import '../model/model.dart';
import '../user.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({required this.roomId, Key? key}) : super(key: key);

  final int roomId;

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  ChatSocket? chatSocket;

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: Chat().getMessages(widget.roomId),
            builder: (builder, AsyncSnapshot<List<Chat>> snapshot) {
              if (snapshot.hasData) {
                List<Chat> messages = snapshot.data!;
                if (messages.isNotEmpty) {
                  return LayoutBuilder(
                    builder: (BuildContext ctx, BoxConstraints constraints) {
                      return GroupedListView<Chat, DateTime>(
                        order: GroupedListOrder.DESC,
                        reverse: true,
                        itemComparator: (message1, message2) =>
                            DateTime.fromMillisecondsSinceEpoch(message1.date!)
                                        .isAfter(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                message2.date!)) ==
                                    true
                                ? 1
                                : -1,
                        useStickyGroupSeparators: true,
                        floatingHeader: true,
                        padding: const EdgeInsets.all(8),
                        elements: messages,
                        groupBy: (message) {
                          DateTime messageDate =
                              DateTime.fromMillisecondsSinceEpoch(
                                  message.date!);
                          return DateTime(
                            messageDate.year,
                            messageDate.month,
                            messageDate.day,
                          );
                        },
                        groupHeaderBuilder: (message) => SizedBox(
                          height: 40,
                          child: Center(
                            child: Card(
                                color: const Color(0xff5537a1),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    DateFormatUtils.yMMMdRU(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            message.date!)),
                                  ),
                                )),
                          ),
                        ),
                        itemBuilder: (_, message) => ChatMessage(
                          message: message,
                          maxWidth: constraints.maxWidth * 0.65,
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("Сообщений нет"));
                }
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        ChatMessageSender(
          roomId: widget.roomId,
          sendMessage: sendMessage,
          refresh: refresh,
        ),
      ],
    );
  }

  Future<void> onJoinChat(dynamic data) async {
    await Chat().select().delete();
    List<dynamic> messages = data.first;
    for (var m in messages) {
      await Chat.withFields(1, DateTime.now().millisecondsSinceEpoch, widget.roomId,
              m['userId'], m['text'], m['date'], 1)
          .save();
    }
    setState(() {});
  }

  void sendMessage(String text) {
    chatSocket?.send(text);
  }

  Future<void> onReceiveMessage(dynamic data) async {
    Room.serverUpdate(sample: true);
    List<dynamic> messages = data;
    for (var m in messages) {
      if ((await Chat().select().user_id.equals(m['userId']).and.message.equals(m['text']).and.date.equals(m['date']).toList()).isEmpty){
        await Chat.withFields(1, DateTime.now().millisecondsSinceEpoch, widget.roomId,
            m['userId'], m['text'], m['date'], 1)
            .save();
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    Room.serverUpdate(sample: true);
    chatSocket = ChatSocket(
        userId: User.params.user_id!,
        roomId: widget.roomId,
        handleJoin: onJoinChat,
        handleSend: onReceiveMessage);
    chatSocket?.openConnection();
    super.initState();
  }

  @override
  void dispose() {
    chatSocket?.closeConnection();
    super.dispose();
  }
}
