import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctone/controllers/auth_controller.dart';
import 'package:synctone/controllers/bottom_navigator_controller.dart';

import '../player/player_controller.dart';

class MainScreen extends StatelessWidget{
   MainScreen({super.key});
   //final PlayerController playerController = Get.put(PlayerController(null));
   final BottomNavigatorController controller = Get.put(BottomNavigatorController());
   final AuthController authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    authC.loadUser();
    return Obx(
        () => GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: SafeArea(
              child: IndexedStack(
                index: controller.index.value,
                children: Get.find<BottomNavigatorController>().screens,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.index.value,
              onTap: (index) => Get.find<BottomNavigatorController>().setIndex(index),
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFF2B2B2B),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              iconSize: 30,
              selectedItemColor: const Color(0xFF8400C4),
              unselectedItemColor: Colors.white,
              items: const<BottomNavigationBarItem> [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled),
                    label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.location_pin),
                    label: 'Location'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.play_arrow),
                    label: 'Player'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.people_alt_rounded),
                    label: 'Friends'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favourites'
                ),
              ],

            )
          ),
        )
    );
  }
}
