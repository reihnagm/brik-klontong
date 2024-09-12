class ProfileModel {
  int status;
  bool error;
  String message;
  ProfileData data;

  ProfileModel({
    required this.status,
    required this.error,
    required this.message,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    status: json["status"],
    error: json["error"],
    message: json["message"],
    data: ProfileData.fromJson(json["data"]),
  );
}

class ProfileData {
  String id;
  String avatar;
  String lastActive;
  bool isOnline;
  String fullname;

  ProfileData({
    required this.id,
    required this.avatar,
    required this.lastActive,
    required this.isOnline,
    required this.fullname,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    id: json["id"],
    avatar: json["avatar"],
    lastActive: json["last_active"],
    isOnline: json["is_online"],
    fullname: json["fullname"],
  );
}