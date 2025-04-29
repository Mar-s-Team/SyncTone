import 'package:get/get.dart';
import 'package:synctone/modules/favourites//favourites_controller.dart';

class FavouritesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouritesController>(
          () => FavouritesController(),
    );
  }
}