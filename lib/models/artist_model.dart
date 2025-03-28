class ArtistModel {
  final String idArtist;
  final String name;
  final String? biography;
  final String? profilePictureUrl;

  ArtistModel({
    required this.idArtist,
    required this.name,
    this.biography,
    this.profilePictureUrl,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      idArtist: json['id_artist'] as String,
      name: json['name'] as String,
      biography: json['biography'] as String?,
      profilePictureUrl: json['profile_picture_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_artist': idArtist,
      'name': name,
      'biography': biography,
      'profile_picture_url': profilePictureUrl,
    };
  }
}
