import 'package:get/get.dart';
import 'package:synctone/modules/settings/settings_controller.dart';


class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(
          () => SettingsController(),
      fenix:true,
    );
  }
}