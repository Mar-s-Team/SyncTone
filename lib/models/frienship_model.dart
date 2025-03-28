class FriendshipModel {
  final String idUser;
  final String idFriend;
  final DateTime createdAt;
  final String status;
  final double? compatibility;

  FriendshipModel({
    required this.idUser,
    required this.idFriend,
    required this.createdAt,
    required this.status,
    this.compatibility,
  });

  factory FriendshipModel.fromJson(Map<String, dynamic> json) {
    return FriendshipModel(
      idUser: json['id_user'] as String,
      idFriend: json['id_friend'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      status: json['status'] as String,
      compatibility: (json['compatibility'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_user': idUser,
      'id_friend': idFriend,
      'created_at': createdAt.toIso8601String(),
      'status': status,
      'compatibility': compatibility,
    };
  }
}
