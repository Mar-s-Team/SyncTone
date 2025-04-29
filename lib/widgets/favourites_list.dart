import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctone/controllers/bottom_navigator_controller.dart';
import 'package:synctone/models/track.dart';
import 'package:synctone/modules/main/main_controller.dart';

import 'home_page/my_round_image.dart';


class FavouritesList extends StatelessWidget {
  FavouritesList({
    required this.list,
    super.key,
  });
  final List<Track> list;
  final MainController mainC = Get.find<MainController>();
  final BottomNavigatorController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child:
        GridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 15,
            childAspectRatio: 5,
            crossAxisCount: 1,
          ),
          itemCount: list.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              mainC.currentSong.value = list[index];
              controller.playSong(list[index]);
            },
            child:
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyRoundImage(height: 180, width: 130, imageUrl: list[index].image),
                const SizedBox(
                  width: 8,
                  height: 100,
                ),
            SizedBox(
              height: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 270,
                    child: Text(
                      list[index].name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 270,
                    child: Text(
                      list[index].artistName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
              ],
            ),
          ),
        )
    );
  }
}