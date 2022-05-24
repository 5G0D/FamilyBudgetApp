import 'dart:convert';

import 'package:family_budget/Server/Response/room_member_response.dart';

class RoomResponse {
  final int id;
  final String name;
  final String photo;
  final String inviteCode;
  final List<RoomMemberResponse> users;

  const RoomResponse({
    required this.id,
    required this.name,
    required this.photo,
    required this.inviteCode,
    required this.users,
  });

  factory RoomResponse.fromJson(Map<String, dynamic> json) {
    List<RoomMemberResponse> users = [];
    for (var u in json['users']) {
      users.add(RoomMemberResponse.fromJson(u));
    }

    return RoomResponse(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
      inviteCode: json['inviteCode'],
      users: users,
    );
  }
}
