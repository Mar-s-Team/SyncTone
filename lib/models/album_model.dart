
import 'artist_model.dart';

class AlbumModel {
  String? idAlbum;
  String? title;
  ArtistModel? artist;
  DateTime? releaseDate;
  String? coverUrl;

  AlbumModel({
    this.idAlbum,
    this.title,
    this.artist,
    this.releaseDate,
    this.coverUrl,
  });

  static fromJson(dynamic json) {
    AlbumModel album = AlbumModel();
    album.idAlbum =  json['id_album'];
    album.title = json['title'] ;
    album.artist = ArtistModel.fromJson(json['artists']);
    album.releaseDate =  DateTime.parse(json['release_date'] as String);
    album.coverUrl = json['cover_url'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id_album': idAlbum,
      'title': title,
      'id_artist': artist?.toJson(),
      'release_date': releaseDate?.toIso8601String(),
      'cover_url': coverUrl,
    };
  }
}
