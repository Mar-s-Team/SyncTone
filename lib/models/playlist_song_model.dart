class PlaylistSongModel {
  final String idPlaylist;
  final String idSong;
  final int position;

  PlaylistSongModel({
    required this.idPlaylist,
    required this.idSong,
    required this.position,
  });

  factory PlaylistSongModel.fromJson(Map<String, dynamic> json) {
    return PlaylistSongModel(
      idPlaylist: json['id_playlist'] as String,
      idSong: json['id_song'] as String,
      position: json['position'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_playlist': idPlaylist,
      'id_song': idSong,
      'position': position,
    };
  }
}
