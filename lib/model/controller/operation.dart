import 'package:family_budget/Server/Controller/operation_controller.dart';
import 'package:family_budget/Server/Response/operation_response.dart';
import 'package:family_budget/model/model.dart' as m;

class Operation{
  static serverUpdate(int userId, int categoryId, int type) async{
    List<OperationResponse>? operations = await OperationController.getCategoryOperation(categoryId);
    if (operations != null){
      await m.Operation().select().user_id.equals(userId).and.category_id.equals(categoryId).delete();
      for (var o in operations){
        m.Operation.withFields(1, DateTime.now().millisecondsSinceEpoch, userId, type, o.id, categoryId, o.date, o.description, o.value.toDouble()).save();
      }
    }
  }
}