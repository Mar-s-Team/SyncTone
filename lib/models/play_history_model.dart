class FavouriteModel {
  final String idFavourite;
  final String idUser;
  final String idSong;
  final DateTime addedDate;

  FavouriteModel({
    required this.idFavourite,
    required this.idUser,
    required this.idSong,
    required this.addedDate,
  });

  static FavouriteModel fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      idFavourite: json['id_favourite'] as String,
      idUser: json['id_user'] as String,
      idSong: json['id_song'] as String,
      addedDate: DateTime.parse(json['added_date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_favourite': idFavourite,
      'id_user': idUser,
      'id_song': idSong,
      'added_date': addedDate.toIso8601String(),
    };
  }

  static List<FavouriteModel> fromJsonList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.map((e) => fromJson(e)).toList();
  }
}
