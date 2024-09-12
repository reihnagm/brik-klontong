class UserActivityModel {
  int status;
  bool error;
  String message;
  List<UserActivityItem> data;

  UserActivityModel({
    required this.status,
    required this.error,
    required this.message,
    required this.data,
  });

  factory UserActivityModel.fromJson(Map<String, dynamic> json) => UserActivityModel(
    status: json["status"],
    error: json["error"],
    message: json["message"],
    data: List<UserActivityItem>.from(json["data"].map((x) => UserActivityItem.fromJson(x))),
  );
}

class UserActivityItem {
  String id;
  String avatar;
  String lastActive;
  bool isOnline;
  String fullname;

  UserActivityItem({
    required this.id,
    required this.avatar,
    required this.lastActive,
    required this.isOnline,
    required this.fullname,
  });

  factory UserActivityItem.fromJson(Map<String, dynamic> json) => UserActivityItem(
    id: json["id"],
    avatar: json["avatar"],
    lastActive: json["last_active"],
    isOnline: json["is_online"],
    fullname: json["fullname"],
  );
}
