class UserResponse {
  final int id;
  final String name;
  final String email;
  final String photo;
  final String token;
  final int? roomId;

  const UserResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
    required this.token,
    this.roomId
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photo: json['photo'],
      token: json['token'],
      roomId: json['roomId'],
    );
  }
}
