import 'package:get/get.dart';

import 'package:synctone/modules/main/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
          () => MainController(),
    );
  }
}