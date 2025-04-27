import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:synctone/models/track.dart';

import 'api_constants.dart';
import 'api_endpoints.dart';

class ApiService {
  static Future<Track?> getTrackById(String id) async {
    Track track;
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}${ApiEndpoints.trackById(id)}${Api.endUrl}'));
      var res = jsonDecode(response.body);

      track = Track.fromMap(res['results'][0]);
      return track;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Track>?> getCustomTracks(String params) async {
    List<Track> tracks = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}$params${Api.endUrl}'));

      var res = jsonDecode(response.body);

      res['results'].forEach(
            (m) => tracks.add(Track.fromMap(m))
      );

      return tracks;
    } catch (e) {
      return null;
    }
  }

}