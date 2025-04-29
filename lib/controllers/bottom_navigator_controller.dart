import 'package:get/get.dart';
import 'package:synctone/api/api_service.dart';
import 'package:synctone/models/track.dart';
import 'package:synctone/modules/friends/friends_screen.dart';
import 'package:synctone/modules/home/home_screen.dart';
import 'package:synctone/modules/location/location_screen.dart';
import 'package:synctone/modules/player/player_controller.dart';
import 'package:synctone/modules/player/player_screen.dart';
import 'package:synctone/modules/favourites/favourites_screen.dart';

class BottomNavigatorController extends GetxController {
  var screens = [
    HomeScreen(),
    LocationScreen(),
    PlayerScreen(),
    const FriendsScreen(),
    const FavouritesScreen(),
  ];
  var index = 0.obs;

  void setIndex(i) async{
    if(i == 2) {
      playSong(await ApiService.getTrackById('1532771'));
    }
    else {
      index.value = i;
    }

  }

    void playSong(Track? track){
      Get.put(PlayerController(track));
      PlayerScreen();
      index.value = 2;
    }

}