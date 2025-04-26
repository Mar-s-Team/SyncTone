import 'package:flutter/material.dart';
import 'package:synctone/models/song_model.dart';

import 'my_round_image.dart';


class SongItem extends StatelessWidget {
  const SongItem({
    super.key,
    required this.song,
    required this.index,
  });

  final SongModel song;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          MyRoundImage(height: 150, width: 150, imageUrl: song.coverUrl as String),
          const SizedBox(height: 5,),
          Text(
            song.title as String,
            style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          )
      ],
    );
  }
}