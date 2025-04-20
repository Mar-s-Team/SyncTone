class UserModel {
  final String idUser;
  final String? firstName;
  final String? lastName;
  final String username;
  final DateTime? createdAt;
  final String? spotifyAccount;
  final String userImage;

  UserModel({
    required this.idUser,
    this.firstName,
    this.lastName,
    required this.username,
    this.createdAt,
    required this.userImage,
    this.spotifyAccount,
  });

  UserModel.friendsRanking({
    required this.idUser,
    required this.username,
    required this.userImage,
  })  : createdAt = null,
        spotifyAccount = null,
        firstName = null,
        lastName = null;

  UserModel.friends({
    required this.idUser,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.userImage,
  })  : createdAt = null,
        spotifyAccount = null;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idUser: json['id_user'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      username: json['username'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      spotifyAccount: json['spotify_account'] as String?,
      userImage: json['user_image'] as String ?? '',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id_user': idUser,
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'created_at': createdAt?.toIso8601String(),
      'spotify_account': spotifyAccount,
    };
  }
}

