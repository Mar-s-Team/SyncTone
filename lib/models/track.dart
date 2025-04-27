import 'dart:convert';

import 'package:synctone/models/music_info.dart';

class Track {
  String id;
  String name;
  int duration;
  String artistId;
  String artistName;
  String albumName;
  String albumId;
  String releaseDate;
  String albumImage;
  String audioUrl;
  String image;
  MusicInfo? musicInfo;


  Track({
      required this.id,
      required this.name,
      required this.duration,
      required this.artistId,
      required this.artistName,
      required this.albumName,
      required this.albumId,
      required this.releaseDate,
      required this.albumImage,
      required this.audioUrl,
      required this.image,
      this.musicInfo
  });

  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      id: map['id'],
      name: map['name'] ?? '',
      duration: map['duration']?.toInt() ?? 0,
      artistId: map['artist_id'] ?? '',
      artistName: map['artist_name'] ?? '',
      albumName: map['album_name'] ?? '',
      albumId: map['album_id'] ?? '',
      releaseDate: map['releasedate'] ?? 'N/A',
      albumImage: map['album_image'] ?? '',
      audioUrl: map['audio'] ?? '',
      image:  map['image'] ?? '',
      musicInfo: getMusicInfo(map),
    );
  }

  static MusicInfo? getMusicInfo(Map<String, dynamic> map) {
    if(map['musicinfo'] == null){
      return null;
    }
  }
  
  factory Track.fromJson(String source) => Track.fromMap(json.decode(source));
}