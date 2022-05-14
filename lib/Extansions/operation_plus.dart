import 'package:family_budget/model/model.dart';

extension OperationPlus on Operation {
  Future<double> getValueByTime(int userId, int startTime, int endTime) async {
    double value = 0;

    for (var o in await Operation()
        .select()
        .user_id
        .equals(userId)
        .and
        .status
        .not
        .equals(0)
        .and
        .date
        .between(startTime, endTime)
        .toList()) {
      value += o.value ?? 0;
    }

    return value;
  }

  Future<double> getValueByDate(
      int userId, int type, DateTime startDate, DateTime endDate) async {

    double value = 0;
    List<Category> categories = await Category()
        .select()
        .user_id
        .equals(userId)
        .and
        .type
        .equals(type)
        .and
        .status
        .not
        .equals(0)
        .toList();

    for (var o in await Operation()
        .select()
        .type
        .equals(type)
        .and
        .status
        .not
        .equals(0)
        .toList()) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(o.date!);

      if (categories.indexWhere((c) => c.category_id! == o.category_id!) > -1 && date.isAfter(startDate) && date.isBefore(endDate)) {
        value += o.value ?? 0;
      }
    }

    return value;
  }
}
