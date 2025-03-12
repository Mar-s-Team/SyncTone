import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctone/controllers/bottom_navigator_controller.dart';
import 'package:synctone/modules/home/home_controller.dart';
import 'package:synctone/modules/main/main_controller.dart';
import 'package:synctone/routes/app_pages.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
              appBar: AppBar(
                title: Text(AppPages.routes[controller.getIndex()].title.toString()),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () async {
                      Get.toNamed(
                        Routes.HOME,
                        //TODO go to settings
                        //    arguments: await controller.getUserProfile(),
                      );
                      Get.put(HomeController());
                    },
                    icon: const Icon(Icons.person),
                    tooltip: "Profile",
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                  currentIndex: controller.getIndex(),
                  onTap: (index) => Get.find<BottomNavigatorController>().setIndex(index),
                  items: const<BottomNavigationBarItem> [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_filled),
                        label: 'Home'
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.people_alt_rounded),
                        label: 'Friends'
                    ),
                  ],

              )
          ),
        )
    );
  }
}