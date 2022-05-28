import 'package:family_budget/model/model.dart';

extension ChatUtils on Chat{
  Future<List<Chat>> getMessages(int roomId) async{
    return await Chat().select().room_id.equals(roomId).and.status.not.equals(0).toList();
  }
}