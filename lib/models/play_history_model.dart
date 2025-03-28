class PlayHistoryModel {
  final String idPlayHistory;
  final String idUser;
  final String idSong;
  final DateTime playDate;
  final int durationPlayed;

  PlayHistoryModel({
    required this.idPlayHistory,
    required this.idUser,
    required this.idSong,
    required this.playDate,
    required this.durationPlayed,
  });

  factory PlayHistoryModel.fromJson(Map<String, dynamic> json) {
    return PlayHistoryModel(
      idPlayHistory: json['id_play_history'] as String,
      idUser: json['id_user'] as String,
      idSong: json['id_song'] as String,
      playDate: DateTime.parse(json['play_date'] as String),
      durationPlayed: json['duration_played'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_play_history': idPlayHistory,
      'id_user': idUser,
      'id_song': idSong,
      'play_date': playDate.toIso8601String(),
      'duration_played': durationPlayed,
    };
  }
}
