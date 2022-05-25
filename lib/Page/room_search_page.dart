import 'dart:convert';

import 'package:family_budget/Extansions/snack_bar_utils.dart';
import 'package:family_budget/Server/Controller/room_controller.dart';
import 'package:family_budget/Server/Response/room_response.dart';
import 'package:family_budget/room.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';

import '../Dialogs/room_exit_dialog.dart';

class RoomSearchPage extends StatefulWidget {
  const RoomSearchPage({Key? key}) : super(key: key);

  @override
  _RoomSearchPageState createState() => _RoomSearchPageState();
}

class _RoomSearchPageState extends State<RoomSearchPage> {
  RoomResponse? _roomResponse;
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поиск комнаты'),
        centerTitle: true,
        backgroundColor: const Color(0xff5537a1),
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff303040),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: TextField(
                      controller: _codeController,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(12),
                        hintText: ('Введите код комнаты'),
                        hintStyle: TextStyle(
                          color: Colors.grey[600]!,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                InkWell(
                  onTap: () async {
                    if (_codeController.text.isEmpty) {
                      SnackBarUtils.Show(
                          context, 'Код комнаты не может быть пустым');
                    } else {
                      _roomResponse = await RoomController.getRoomByInviteCode(
                          _codeController.text,
                          context: context);
                      setState(() {});
                    }
                  },
                  splashFactory: NoSplash.splashFactory,
                  highlightColor: Colors.transparent,
                  child: ClipOval(
                    child: Container(
                      width: 48,
                      height: 48,
                      padding: const EdgeInsets.only(left: 2),
                      //color: const Color(0xff5537a1).withOpacity(0),
                      child: const Icon(
                        Icons.search,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded( child:
            ListView(
            children: [(_roomResponse == null)
                ? Container(padding: const EdgeInsets.symmetric(vertical: 40), child: const Center(
                    child: Text('Необходимо создать или вступить в комнату'),
                  ),)
                : ListTile(
                    title: Card(
                      elevation: 4,
                      color: const Color(0xff303040),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 80,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              width: 60,
                              height: 60,
                              child: ClipOval(
                                child: Image.memory(
                                  base64Decode(_roomResponse!.photo),
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _roomResponse!.name,
                                    style: const TextStyle(fontSize: 18),
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text('Участников: ' +
                                      _roomResponse!.users.length.toString())
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                //Выход
                                if (User.params.roomId != null){
                                  if ((await roomExitDialog(context)) == 'NO'){
                                    return;
                                  }
                                  if (!await Room.roomExit(context: context)){
                                    return;
                                  }
                                }
                                //Вход
                                if (await RoomController.addUserToRoom(User.params.user_id!, _roomResponse!.id, context: context)){
                                  await Room.roomEnter(_roomResponse!);
                                  Navigator.pushReplacementNamed(context, '/home');
                                }
                              },
                              splashRadius: 30,
                              icon: const Icon(
                                Icons.login,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff5537a1)),
                  ),
                  child: const Text('Создать комнату',style: TextStyle(fontSize: 16),),
                  onPressed: () {
                    Navigator.pushNamed(context, '/room_search/create');
                  },
                ),
              ),
            ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }
}
