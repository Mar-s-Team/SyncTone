import 'dart:convert';

class MusicInfo {
  String vocalInstrumental;
  String lang;
  String gender;
  String acousticElectric;
  List<String> tags;
  List<String> instruments;
  String speed;


  MusicInfo({
  required this.vocalInstrumental,
  required this.lang,
  required this.gender,
  required this.acousticElectric,
  required this.tags,
  required this.instruments,
  required this.speed,
  });

  factory MusicInfo.fromMap(Map<String, dynamic> map) {
    return MusicInfo(
        vocalInstrumental: map['vocalinstrumental'] ?? '',
        lang: map['lang'] ?? '',
        gender: map['gender'] ?? '',
        acousticElectric: map['acousticelectric'] ?? '',
        tags: map['tags']['genres'] ?? '',
        instruments: map['tags']['instruments'] ?? '',
        speed: map['speed'] ?? '',
    );
  }

  factory MusicInfo.fromJson(String source) => MusicInfo.fromMap(json.decode(source));


}