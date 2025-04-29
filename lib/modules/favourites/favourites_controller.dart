import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synctone/api/api_service.dart';
import 'package:synctone/models/play_history_model.dart';
import 'package:synctone/models/track.dart';

class FavouritesController extends GetxController {
  var isLoading = false.obs;
  SupabaseClient client = Supabase.instance.client;
  RxList<Track> favourites = List<Track>.empty().obs;

  @override
  void onInit() async {
    isLoading.value = true;
    await getFavourites();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> getFavourites() async {
    try {
      final responseData = await client.from('favourites')
          .select('*')
          .eq('id_user', client.auth.currentUser!.id);
      List<FavouriteModel> favs = FavouriteModel.fromJsonList(responseData);
      List<Track> tracks = [];
      for(FavouriteModel fav in favs) {
        Track? track = await ApiService.getTrackById(fav.idSong);
        tracks.add(track!);
      }
      favourites(tracks);
      favourites.refresh();
    } catch (e) {
      print("Error al recuperar favoritos: $e");
    }
  }

}
