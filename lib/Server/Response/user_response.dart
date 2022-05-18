class UserResponse {
  final String name;
  final String email;
  final String photo;
  final String token;

  const UserResponse({
    required this.name,
    required this.email,
    required this.photo,
    required this.token,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      name: json['name'],
      email: json['email'],
      photo: json['photo'],
      token: json['token'],
    );
  }
}
