import 'package:spotify/spotify.dart';
import 'package:synctone/models/album_model.dart';
import 'package:synctone/models/artist_model.dart';
import 'package:synctone/models/genre_model.dart';

class SongModel {
  String? idSong;
  String? title;
  AlbumModel? album;
  ArtistModel? artist;
  int? duration;
  DateTime? releaseDate;
  String? fileUrl;
  GenreModel? genre;
  String? coverUrl;

  SongModel({
     this.idSong,
     this.title,
     this.album,
     this.artist,
     this.duration,
     this.releaseDate,
     this.fileUrl,
     this.genre,
     this.coverUrl
  });

  Map<String, dynamic> toJson() {
    return {
      'id_song': idSong,
      'title': title,
      'album': album?.toJson(),
      'artist': artist?.toJson(),
      'duration': duration,
      'release_date': releaseDate?.toIso8601String(),
      'file_url': fileUrl,
      'id_genre': genre?.toJson(),
      'cover_url': coverUrl
    };
  }

  static SongModel fromJson(dynamic json){
    SongModel song = SongModel();
    song.idSong = json['id_song'];
    song.title = json['title'];
    song.artist = ArtistModel.fromJson(json['artists']);
    song.album = AlbumModel.fromJson(json['albums']);
    song.duration = json['duration'];
    song.releaseDate = DateTime.parse(json['release_date']);
    song.fileUrl = json['file_url'];
    song.genre = GenreModel.fromJson(json['genres']);
    song.coverUrl = json['cover_url'];
    return song;
  }

  static List<SongModel> fromJsonList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.map((e) => fromJson(e)).toList();
  }
}
