import 'package:get/get.dart';
import 'package:synctone/modules/playlists/playlists_controller.dart';

class PlaylistsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaylistsController>(
          () => PlaylistsController(),
    );
  }
}