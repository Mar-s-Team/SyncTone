class GenreModel {
  String? idGenre;
  String? name;
  String? description;

  GenreModel({
    this.idGenre,
    this.name,
    this.description,
  });

  static GenreModel fromJson(dynamic json){
    return GenreModel(
      idGenre: json['id_genre'],
      name: json['name'],
      description: json['description'],
    );
  }

  factory GenreModel.fromMap(Map<String, dynamic> json) {
    return GenreModel(
      idGenre: json['id_genre'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_genre': idGenre,
      'name': name,
      'description': description,
    };
  }
}
