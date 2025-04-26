import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:synctone/models/song_model.dart';
import 'package:synctone/widgets/home_page/song_item.dart';

class SongListView extends StatelessWidget {
  final RxList<SongModel> songs;
  const SongListView({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: songs.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, __) => const SizedBox(width: 24),
      itemBuilder: (_, index) => SongItem(
        song: songs[index],
        index: index + 1,),
    );
  }
}