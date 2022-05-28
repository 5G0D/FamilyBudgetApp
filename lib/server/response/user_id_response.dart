class UserIdResponse{
  final int id;

  const UserIdResponse({required this.id});

  factory UserIdResponse.fromJson(Map<String, dynamic> json) {
    return UserIdResponse(
      id: json['id'],
    );
  }
}