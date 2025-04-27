import 'package:flutter/material.dart';
import 'package:synctone/models/track.dart';

import 'my_round_image.dart';


class SongItem extends StatelessWidget {
  const SongItem({
    super.key,
    required this.song,
  });

  final Track song;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          MyRoundImage(height: 150, width: 150, imageUrl: song.image),
          const SizedBox(height: 5,),
          Text(
            song.name,
            style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          )
      ],
    );
  }
}