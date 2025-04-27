import 'package:get/get.dart';
import 'package:synctone/modules/player/player_controller.dart';

class PlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayerController>(
          () => PlayerController(null),
    );
  }
}