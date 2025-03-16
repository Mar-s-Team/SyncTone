import 'package:get/get.dart';
import 'package:synctone/modules/friends/friends_screen.dart';
import 'package:synctone/modules/home/home_screen.dart';
import 'package:synctone/modules/location/location_screen.dart';
import 'package:synctone/modules/player/player_screen.dart';
import 'package:synctone/modules/playlists/playlists_screen.dart';
import 'package:synctone/modules/stats/stats_screen.dart';

class BottomNavigatorController extends GetxController {
  var screens = const [
    HomeScreen(),
    LocationScreen(),
    PlayerScreen(),
    StatsScreen(),
    FriendsScreen(),
    PlaylistsScreen(),
  ];
  var index = 0.obs;

  void setIndex(i) => index.value = i;
}