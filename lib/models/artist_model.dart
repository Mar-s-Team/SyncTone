class ArtistModel {
  String? idArtist;
  String? name;
  String? biography;
  String? profilePictureUrl;

  ArtistModel({
    this.idArtist,
    this.name,
    this.biography,
    this.profilePictureUrl,
  });

  static ArtistModel fromJson(dynamic json){
    return ArtistModel(
      idArtist: json['id_artist'],
      name: json['name'],
      biography: json['biography'],
      profilePictureUrl: json['profile_picture_url'],
    );
  }

  factory ArtistModel.fromMap(Map<String, dynamic> json) {
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
