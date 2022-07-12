import 'dart:convert';

import 'package:family_budget/Server/Controller/room_controller.dart';
import 'package:family_budget/Server/Response/room_response.dart';
import 'package:family_budget/Server/Response/user_response.dart';
import 'package:family_budget/model/controller/room.dart';
import 'package:family_budget/model/model.dart';

class User {
  static late UserParam _userParams;
  static UserParam get params => _userParams;

  static update() async {
    _userParams = UserParam();
    try {
      List users = (await UserParam()
          .select()
          .status
          .not
          .equals(0)
          .orderByDesc("date_modify")
          .toList());
      if (users.isNotEmpty) {
        _userParams = users.first;
      }
    } catch (e) {}
  }

  static userExit() async {
    _userParams = UserParam();

    await UserParam().select().delete();
    await Setting().select().delete();
    await Category().select().delete();
    await Operation().select().delete();
    await RoomMember().select().delete();
    await RoomParam().select().delete();
    await Chat().select().delete();
  }

  static userLogin(UserResponse userResponse) async {
    UserParam user = UserParam.withFields(1, DateTime.now().millisecondsSinceEpoch, userResponse.id, userResponse.name, userResponse.email, userResponse.token, base64Decode(userResponse.photo), userResponse.roomId);
    await user.save();
    _userParams = user;

    if (_userParams.roomId != null){
      RoomResponse? roomResponse = await RoomController.getRoom(_userParams.roomId!);
      if (roomResponse != null) {
        await Room.roomEnter(roomResponse);
      }
    }
  }
}
