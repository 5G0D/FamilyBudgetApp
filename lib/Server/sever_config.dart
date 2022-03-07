import 'package:family_budget/model/model.dart';

class ServerConfig{
  static bool get connected => true;

  static Future<bool> logged() async{
    return true;
  }
}