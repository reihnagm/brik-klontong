class AuthModel {
  int status;
  bool error;
  String message;
  AuthData data;

  AuthModel({
    required this.status,
    required this.error,
    required this.message,
    required this.data,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    status: json["status"],
    error: json["error"],
    message: json["message"],
    data: AuthData.fromJson(json["data"]),
  );
}

class AuthData {
  String token;
  String refreshToken;
  AuthUser user;

  AuthData({
    required this.token,
    required this.refreshToken,
    required this.user,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) => AuthData(
    token: json["token"],
    refreshToken: json["refresh_token"],
    user: AuthUser.fromJson(json["user"]),
  );
}

class AuthUser {
  String id;
  String name;
  String email;

  AuthUser({
    required this.id,
    required this.name,
    required this.email,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
    id: json["id"],
    name: json["name"],
    email: json["email"],
  );
}
