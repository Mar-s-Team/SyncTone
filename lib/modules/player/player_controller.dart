import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synctone/models/track.dart';

import '../../models/user_model.dart';
import '../favourites/favourites_controller.dart';
import 'package:synctone/controllers/auth_controller.dart';

class PlayerController extends GetxController {
  AuthController authC = Get.find<AuthController>();
  UserModel? loggedUser;

  Track? currentSong;
  SupabaseClient client = Supabase.instance.client;

  PlayerController(this.currentSong);

  Future<void> addToFavouritesList(Track track) async{
    try{
      await client.from('favourites').insert({
        'id_user': loggedUser?.idUser, 'id_song': track.id
      });
      FavouritesController favC = Get.find();
      favC.getFavourites();
    }
    catch(e){
      print(e);
    }
  }
}
