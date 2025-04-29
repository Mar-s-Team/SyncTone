import 'package:flutter/material.dart';
import 'package:synctone/models/track.dart';

class NowPlayingImage extends StatelessWidget {
  final Track song;

  const NowPlayingImage({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: 240,
          height: 240,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(song.image),
              )
          ),
         ),
        Container(
          width: 240,
          height: 240,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.transparent, Color(0xFF2B2B2B)],
                stops: [0.5, 1.0],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
              song.name,
              style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
              song.artistName,
              style: const TextStyle(fontSize: 18, color: Colors.white54, fontWeight: FontWeight.bold,),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5,)
              ],
              ),
          ),

        )
      ],
    );
  }
}
