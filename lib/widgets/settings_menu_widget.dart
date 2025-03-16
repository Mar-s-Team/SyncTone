import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctone/routes/app_pages.dart';

class SettingsMenuWidget extends StatelessWidget {
  const SettingsMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.SETTINGS);
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: const CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
              'https://www.example.com/your_image_url.jpg'),
        ),
      )
    );
  }
}
