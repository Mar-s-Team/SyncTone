import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synctone/controllers/bottom_navigator_controller.dart';
import 'package:synctone/models/track.dart';
import 'package:synctone/modules/player/player_controller.dart';
import 'package:synctone/modules/player/player_screen.dart';

import '../../api/api_endpoints.dart';
import '../../api/api_service.dart';

class MainController extends GetxController {
  final BottomNavigatorController bottomNavController =  Get.put(BottomNavigatorController());
  Rx<Track> currentSong = Track(
      id: "1532771",
      name: "Let Me Hear You I",
      duration: 54,
      artistId: '461414',
      artistName: 'Paul Werner',
      albumName: 'Let Me Hear You I',
      albumId: '404140',
      releaseDate: '2018-03-15',
      albumImage: 'https:\/\/usercontent.jamendo.com?type=album&id=404140&width=300&trackid=1532771',
      audioUrl: 'https:\/\/prod-1.storage.jamendo.com\/?trackid=1532771&format=mp31&from=K4wtiuZwKN3fwiRtuJ4JIw%3D%3D%7CLiDIe8pfkkxttLl33pWCRg%3D%3D',
      image: 'https:\/\/usercontent.jamendo.com?type=album&id=404140&width=300&trackid=1532771')
      .obs;

  void setIndex(i) {bottomNavController.index.value = i;  }

  int getIndex(){return bottomNavController.index.value;}

  void playSong(Track track){
    Get.put(PlayerController(track));
    PlayerScreen();
    setIndex(2);
  }
  var isLoading = false.obs;
  SupabaseClient client = Supabase.instance.client;
  RxList<Track> newReleases = List<Track>.empty().obs;
  RxList<Track> trendingSpanish = List<Track>.empty().obs;

  @override
  void onInit() async {
    isLoading.value = true;
    await getNewReleases();
    await getTrendingSpanish();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> getNewReleases() async {
    List<Track>? newReleasesData = await ApiService.getCustomTracks(ApiEndpoints.newReleases);
    newReleases(newReleasesData);
    newReleases.refresh();
  }

  Future<void> getTrendingSpanish() async {
    List<Track>? trendingSpanishData = await ApiService.getCustomTracks(ApiEndpoints.trendingSpanish);
    trendingSpanish(trendingSpanishData);
    trendingSpanish.refresh();
  }


}