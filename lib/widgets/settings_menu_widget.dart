import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctone/routes/app_pages.dart';

import '../modules/settings/settings_controller.dart';

class SettingsMenuWidget extends StatelessWidget {
  const SettingsMenuWidget({super.key});


  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.put(SettingsController());
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.SETTINGS);
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: Obx(() => CircleAvatar(
          radius: 20,
          backgroundImage: settingsController.userImage.isNotEmpty
              ? NetworkImage(settingsController.userImage.value)
              : const NetworkImage('https://cdn-icons-png.freepik.com/512/8211/8211048.png')
        )),
      )
    );
  }
}
