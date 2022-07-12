

class RoomMemberResponse {
  final int id;
  final String name;
  final String email;
  final String photo;
  final int role;
  final String userColor;

  const RoomMemberResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
    required this.role,
    required this.userColor,
  });

  factory RoomMemberResponse.fromJson(Map<String, dynamic> json) {
    return RoomMemberResponse(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photo: json['photo'],
      role: json['role'],
      userColor: json['userColor'],
    );
  }
}