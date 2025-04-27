import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:synctone/controllers/auth_controller.dart';
import 'package:synctone/controllers/bottom_navigator_controller.dart';
import 'package:synctone/models/track.dart';
import 'package:synctone/routes/app_pages.dart';
import 'package:synctone/widgets/home_page/song_item.dart';

class SongListView extends StatelessWidget {
  final RxList<Track> songs;
  final AuthController authC = Get.find();
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
          authC.currentSong = songs[index];
          controller.setIndex(2);
        },
        child: SongItem(song: songs[index],),
      ),
    );
  }
}