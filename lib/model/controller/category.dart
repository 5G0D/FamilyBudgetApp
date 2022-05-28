import 'package:family_budget/Model/model.dart';
import 'package:family_budget/Server/Controller/category_controller.dart';
import 'package:family_budget/Server/Response/category_response.dart';
import 'package:family_budget/model/controller/operation.dart' as o;
import 'package:family_budget/model/model.dart' as m;

class Category{
  static serverUpdate(int roomMemberId) async{
    List<CategoryResponse>? categories = await CategoryController.getUserCategory(roomMemberId);
    if (categories != null){
      await m.Category().select().user_id.equals(roomMemberId).delete();
      for (var c in categories){
        m.Category.withFields(1, DateTime.now().millisecondsSinceEpoch, c.id, roomMemberId, c.name, int.parse(c.iconCode), int.parse(c.iconColor), c.blockLocation, c.positionLocation, c.moneyFlowType).save();
        o.Operation.serverUpdate(roomMemberId, c.id, c.moneyFlowType);
      }
    }
  }

  static serverUpdateAll() async{
    for (var m in await RoomMember().select().status.not.equals(0).toList()){
      await serverUpdate(m.user_id!);
    }
  }
}