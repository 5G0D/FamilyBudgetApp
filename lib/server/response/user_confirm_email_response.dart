class UserConfirmEmailResponse{
  final bool isEmailConfirm;

  const UserConfirmEmailResponse({required this.isEmailConfirm});

  factory UserConfirmEmailResponse.fromJson(Map<String, dynamic> json) {
    return UserConfirmEmailResponse(
      isEmailConfirm: json['isEmailConfirm'],
    );
  }
}