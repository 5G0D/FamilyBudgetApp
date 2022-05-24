import 'dart:convert';

import 'package:family_budget/Page/room_search_page.dart';
import 'package:family_budget/Server/Controller/room_controller.dart';
import 'package:family_budget/Server/Response/room_member_response.dart';
import 'package:family_budget/Server/Response/room_response.dart';
import 'package:family_budget/category.dart' as c;
import 'package:family_budget/main.dart';
import 'package:family_budget/model/model.dart' as m;
import 'package:family_budget/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class Room {
  static late m.RoomParam _roomParams;
  static m.RoomParam get params => _roomParams;

  static update({bool waitUpdate = false}) async {
    _roomParams = m.RoomParam();
    try {
      List rooms = (await m.RoomParam()
          .select()
          .status
          .not
          .equals(0)
          .orderByDesc("date_modify")
          .toList());
      if (rooms.isNotEmpty) {
        _roomParams = rooms.first;
      }
    } catch (e) {}

    serverUpdate();
  }

  static serverUpdate() async{
    if (_roomParams.room_id != null){
      RoomResponse? roomResponse = await RoomController.getRoom(_roomParams.room_id!);
      if (roomResponse != null) {
        //Выход из комнаты
        if (roomResponse.users.indexWhere((u) => u.id == User.params.user_id) == -1){
          User.params.roomId = null;
          await User.params.save();
          roomExit();
          navigatorKey.currentState?.pushReplacementNamed('/room_search');
        }
        //Обновление данных комнаты
        else {
          await m.RoomParam().select().delete();
          m.RoomParam room = m.RoomParam.withFields(1, DateTime.now().millisecondsSinceEpoch, roomResponse.id, roomResponse.name, base64Decode(roomResponse.photo), roomResponse.inviteCode);
          await room.save();
          Room._roomParams = room;

          await m.RoomMember().select().delete();

          for (var u in roomResponse.users){
            await m.RoomMember.withFields(1, DateTime.now().millisecondsSinceEpoch, roomResponse.id, u.id, u.name, base64Decode(u.photo), int.parse(u.userColor), u.role).save();
            await c.Category.serverUpdate(u.id);
          }
        }
      }
    }
  }

  static Future<bool> roomExit({BuildContext? context}) async {
    if (User.params.roomId == null || await RoomController.deleteUserFromRoom(User.params.user_id!, User.params.roomId!, context: context)){
      _roomParams = m.RoomParam();

      await m.Category().select().delete();
      await m.Operation().select().delete();
      await m.RoomMember().select().delete();
      await m.RoomParam().select().delete();
      await m.Chat().select().delete();

      return true;
    }

    return false;
  }

  static roomEnter(RoomResponse roomResponse) async {
    m.RoomParam room = m.RoomParam.withFields(1, DateTime.now().millisecondsSinceEpoch, roomResponse.id, roomResponse.name, base64Decode(roomResponse.photo), roomResponse.inviteCode);
    await room.save();
    _roomParams = room;

    User.params.roomId = _roomParams.room_id;
    User.params.save();

    await serverUpdate();
  }

  static Future<m.RoomMember?> getUserMemberRecord() async {
    List<m.RoomMember> members = await m.RoomMember().select().user_id.equals(User.params.user_id).and.status.not.equals(0).toList();

    if (members.isNotEmpty){
      return members.first;
    }

    return null;
  }
}
