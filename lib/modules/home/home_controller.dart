import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synctone/models/song_model.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  SupabaseClient client = Supabase.instance.client;
  RxList<SongModel> newReleases = List<SongModel>.empty().obs;

  @override
  void onInit() async {
    isLoading.value = true;
    await getNewReleases();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> getNewReleases() async {
    try{
      List<dynamic> songs = await client
          .from('songs')
          .select('*, albums(*, artists(*)), artists(*), genres(*)')
          .order('release_date')
          .limit(3);

      List<SongModel> songsData = SongModel.fromJsonList(songs);
      newReleases(songsData);
      newReleases.refresh();
    }
    catch (e){
      print("Error al recuperar new releases: $e");
    }
  }

}