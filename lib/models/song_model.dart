class SongModel {
  final String idSong;
  final String title;
  final String idAlbum;
  final String idArtist;
  final int duration;
  final DateTime releaseDate;
  final String fileUrl;
  final String idGenre;

  SongModel({
    required this.idSong,
    required this.title,
    required this.idAlbum,
    required this.idArtist,
    required this.duration,
    required this.releaseDate,
    required this.fileUrl,
    required this.idGenre,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      idSong: json['id_song'] as String,
      title: json['title'] as String,
      idAlbum: json['id_album'] as String,
      idArtist: json['id_artist'] as String,
      duration: json['duration'] as int,
      releaseDate: DateTime.parse(json['release_date'] as String),
      fileUrl: json['file_url'] as String,
      idGenre: json['id_genre'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_song': idSong,
      'title': title,
      'id_album': idAlbum,
      'id_artist': idArtist,
      'duration': duration,
      'release_date': releaseDate.toIso8601String(),
      'file_url': fileUrl,
      'id_genre': idGenre,
    };
  }
}
