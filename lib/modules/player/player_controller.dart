import 'package:get/get.dart';
import 'package:synctone/models/track.dart';

class PlayerController extends GetxController {
  Track? currentSong;

  PlayerController(this.currentSong);
}
