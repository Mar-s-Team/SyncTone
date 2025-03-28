class PlaylistModel {
  final String idPlaylist;
  final String idUser;
  final String name;
  final String? description;
  final DateTime createdAt;
  final bool isPublic;

  PlaylistModel({
    required this.idPlaylist,
    required this.idUser,
    required this.name,
    this.description,
    required this.createdAt,
    required this.isPublic,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    return PlaylistModel(
      idPlaylist: json['id_playlist'] as String,
      idUser: json['id_user'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      isPublic: json['is_public'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_playlist': idPlaylist,
      'id_user': idUser,
      'name': name,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'is_public': isPublic,
    };
  }
}
