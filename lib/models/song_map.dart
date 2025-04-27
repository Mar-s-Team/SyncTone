class SongMap {
  final String id;
  final String title;
  final double latitude;
  final double longitude;

  SongMap({
    required this.id,
    required this.title,
    required this.latitude,
    required this.longitude,
  });

  factory SongMap.fromJson(Map<String, dynamic> json) {
    return SongMap(
      id: json['id'] as String,
      title: json['title'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
