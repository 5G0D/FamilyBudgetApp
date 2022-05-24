import 'package:family_budget/Behavior/scroll_behavior.dart';
import 'package:family_budget/Dialogs/room_member_kick_dialog.dart';
import 'package:family_budget/Enums/room_member_role_enum.dart';
import 'package:family_budget/Extansions/snack_bar_utils.dart';
import 'package:family_budget/Server/Controller/room_controller.dart';
import 'package:family_budget/model/model.dart';
import 'package:family_budget/room.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({Key? key}) : super(key: key);

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  Future<void> _update() async {
    await Room.serverUpdate();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Room.getUserMemberRecord(),
      builder: (builder, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          RoomMember? _userMemberRecord = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                Room.params.name!,
                softWrap: false,
                overflow: TextOverflow.fade,
              ),
              centerTitle: true,
              backgroundColor: const Color(0xff5537a1),
              actions: [
                if (_userMemberRecord?.user_role ==
                    RoomMemberRoleEnum.owner.index)
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
            body: FutureBuilder(
              future: RoomMember().select().status.not.equals(0).toList(),
              builder: (builder, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  List<RoomMember> members = snapshot.data!;
                  return Column(
                    children: [
                      Container(
                        height: 40,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xff4a3480),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(text: "Код приглашения: "),
                                TextSpan(
                                    text: Room.params.invite_code!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      ScrollConfiguration(
                        behavior: CustomScrollBehavior(),
                        child: Expanded(
                          child: RefreshIndicator(
                            onRefresh: _update,
                            child: ListView.builder(
                              itemCount: members.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Card(
                                    elevation: 4,
                                    color: const Color(0xff303040),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color:
                                              Color(members[index].user_color!)
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                members[index].user_name!,
                                                softWrap: false,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    color: Color(members[index]
                                                        .user_color!)),
                                              ),
                                            ),
                                          ),
                                          if (_userMemberRecord?.user_role! ==
                                                  RoomMemberRoleEnum
                                                      .owner.index &&
                                              members[index].user_id! !=
                                                  User.params.user_id!)
                                            IconButton(
                                              onPressed: () async {
                                                if ((await roomMemberKickDialog(
                                                        context,
                                                        members[index]
                                                            .user_name!)) ==
                                                    'YES') {
                                                  if (await RoomController
                                                      .deleteUserFromRoom(
                                                    members[index].user_id!,
                                                    Room.params.room_id!,
                                                    context: context,
                                                  )) {
                                                    members[index].status = 0;
                                                    await members[index].save();
                                                    setState(() {
                                                      SnackBarUtils.Show(
                                                          context,
                                                          'Пользователь ' +
                                                              members[index]
                                                                  .user_name! +
                                                              ' исключен из комнаты');
                                                    });
                                                  }
                                                }
                                              },
                                              splashRadius: 25,
                                              icon: const Icon(
                                                Icons.clear,
                                                size: 30,
                                                color: Colors.red,
                                              ),
                                            ),
                                          if (members[index].user_role ==
                                              RoomMemberRoleEnum.owner.index)
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Icon(
                                                Icons.star_outlined,
                                                size: 30,
                                                color: Colors.yellow,
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
                        ),
                      ),
                    ],
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _update();
  }
}
