class GenreModel {
  final String idGenre;
  final String name;
  final String? description;

  GenreModel({
    required this.idGenre,
    required this.name,
    this.description,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
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
