import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:synctone/controllers/bottom_navigator_controller.dart';
import 'package:synctone/models/track.dart';
import 'package:synctone/widgets/home_page/song_item.dart';
import '../../modules/main/main_controller.dart';

class SongListView extends StatelessWidget {
  final RxList<Track> songs;
  final MainController mainC = Get.find<MainController>();
  final BottomNavigatorController controller = Get.find();
  SongListView({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: songs.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, __) => const SizedBox(width: 24),
      itemBuilder: (_, index) => GestureDetector(
        onTap: (){
          mainC.currentSong.value = songs[index];
          controller.playSong(songs[index]);
        },
        child: SongItem(song: songs[index],),
      ),
    );
  }
}