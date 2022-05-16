import 'package:family_budget/Behavior/scroll_behavior.dart';
import 'package:family_budget/Dialogs/room_member_kick_dialog.dart';
import 'package:family_budget/Model/model.dart';
import 'package:family_budget/room.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({Key? key}) : super(key: key);

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            Room.params.name!,
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
        ),
        backgroundColor: const Color(0xff5537a1),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit_rounded,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                '/room/edit',
              );
              setState(() {});
            },
            padding: const EdgeInsets.all(10),
            splashRadius: 25,
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: RoomMember().select().status.not.equals(0).toList(),
          builder: (builder, AsyncSnapshot<List<RoomMember>> snapshot) {
            if (snapshot.hasData) {
              List<RoomMember> members = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: ListView.builder(
                    itemCount: members.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Card(
                          elevation: 4,
                          color: const Color(0xff303040),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Color(members[index].user_color!)
                                    .withOpacity(0.3),
                                width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            height: 65,
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                ClipOval(
                                  child: Image.memory(
                                    members[index].user_avatar!,
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      members[index].user_name!,
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          color: Color(
                                              members[index].user_color!)),
                                    ),
                                  ),
                                ),
                                if (members[index].user_id! !=
                                    User.params.user_id!)
                                  IconButton(
                                    onPressed: () async {
                                      if ((await roomMemberKickDialog(context,
                                              members[index].user_name!)) ==
                                          'YES') {
                                        members[index].status = 0;
                                        await members[index].save();
                                        setState(() {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text('Пользователь ' +
                                                  members[index].user_name! +
                                                  ' исключен из комнаты'),
                                            ),
                                          );
                                        });
                                      }
                                    },
                                    splashRadius: 25,
                                    icon: const Icon(
                                      Icons.clear,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
