import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:synctone/modules/home/home_controller.dart';
import 'package:synctone/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              Get.toNamed(
               Routes.LOGIN,
            //    arguments: await controller.getUserProfile(),
              );
              Get.put(HomeController());
            },
            icon: const Icon(Icons.person),
            tooltip: "Profile",
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            height: 100,
          )
        ],
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: controller.bottomBarController,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.home_filled, color: Colors.blueGrey,),
            activeItem: Icon( Icons.home_filled,color: Colors.blueAccent,),
            itemLabel: 'Page 1',
            ),
        ],
        onTap: (int value) {
          Get.toNamed(Routes.HOME);
        },
        kIconSize: 200.0,
        kBottomRadius: 200.0,
      )
    );
  }
}