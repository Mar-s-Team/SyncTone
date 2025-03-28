class AlbumModel {
  final String idAlbum;
  final String title;
  final String idArtist;
  final DateTime releaseDate;
  final String? coverUrl;

  AlbumModel({
    required this.idAlbum,
    required this.title,
    required this.idArtist,
    required this.releaseDate,
    this.coverUrl,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      idAlbum: json['id_album'] as String,
      title: json['title'] as String,
      idArtist: json['id_artist'] as String,
      releaseDate: DateTime.parse(json['release_date'] as String),
      coverUrl: json['cover_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_album': idAlbum,
      'title': title,
      'id_artist': idArtist,
      'release_date': releaseDate.toIso8601String(),
      'cover_url': coverUrl,
    };
  }
}
