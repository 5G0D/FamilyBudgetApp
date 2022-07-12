import 'package:family_budget/Extensions/room_member_utils.dart';
import 'package:family_budget/model/controller/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/model.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({required this.message, required this.maxWidth, Key? key})
      : super(key: key);

  final Chat message;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    bool isUserMessage = message.user_id! == User.params.user_id;

    if (isUserMessage) {
      return Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (message.message_status == 2)
              Container(
                width: 15,
                height: 15,
                margin: const EdgeInsets.only(bottom: 8, right: 4),
                child: const CircularProgressIndicator(),
              ),
            Card(
              elevation: 8,
              color: const Color(0xff303040),
              child: Container(
                constraints: BoxConstraints(maxWidth: maxWidth),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      message.message ?? '',
                      style: const TextStyle(fontSize: 14),
                      softWrap: true,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 4, top: 4),
                      child: Text(
                        DateFormat('HH:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(message.date!),
                        ),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return FutureBuilder(
      future: RoomMember().getByUserId(message.user_id!),
      builder: (builder, AsyncSnapshot<RoomMember> snapshot) {
        if (snapshot.hasData) {
          RoomMember member = snapshot.data!;
          if (member.id == null) {
            return SizedBox.shrink();
          }
          else {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: ClipOval(
                    child: Image.memory(
                      member.user_avatar!,
                      width: 35,
                      height: 35,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Card(
                  elevation: 8,
                  color: const Color(0xff303040),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: maxWidth),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              member.user_name!,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color(member.user_color!)),
                            ),
                            Text(
                              message.message ?? '',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 4, right: 4),
                        child: Text(
                          DateFormat('HH:mm').format(
                            DateTime.fromMillisecondsSinceEpoch(message.date!),
                          ),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
