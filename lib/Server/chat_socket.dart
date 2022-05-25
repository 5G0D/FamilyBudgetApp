import 'package:family_budget/Server/sever_config.dart';
import 'package:family_budget/room.dart';
import 'package:family_budget/user.dart';
import 'package:signalr_netcore/signalr_client.dart';

class ChatSocket{
  HubConnection? hubConnection;

  Function(dynamic) handleJoin;
  Function(dynamic) handleSend;
  int roomId;
  int userId;

  ChatSocket({
    required this.userId,
    required this.roomId,
    required this.handleJoin,
    required this.handleSend,
  });

  Future<void> openConnection() async {
    try {
      hubConnection = HubConnectionBuilder().withUrl(ServerConfig.httpLink + "/chat").build();

      hubConnection?.on('Join', handleJoin);
      hubConnection?.on('Send', handleSend);

      hubConnection?.start()?.whenComplete(() => joinChat());
    } catch (e) {
      print("Ошибка подключения к хабу: $e");
    }
  }

  closeConnection(){
    hubConnection?.stop();
  }

  joinChat(){
    if (hubConnection?.state == HubConnectionState.Connected){
      hubConnection?.invoke("Join", args: [{'RoomId': roomId}]);
    }
  }

  send(String text){
    if (hubConnection?.state == HubConnectionState.Connected){
      hubConnection?.invoke("Send", args: [{'RoomId': roomId, 'UserId': userId, 'Text': text, 'Date': DateTime.now().millisecondsSinceEpoch}]);
    }
  }

}