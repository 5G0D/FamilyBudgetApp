import 'package:family_budget/model/model.dart';

extension RoomMemberUtils on RoomMember{
  Future<RoomMember> getByUserId(int userId) async{
    List members = await select().user_id.equals(userId).toList();
    if (members.isNotEmpty){
      return members.first;
    }

    return RoomMember();
  }
}