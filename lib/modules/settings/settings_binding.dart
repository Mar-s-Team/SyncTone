import 'package:get/get.dart';
import 'package:synctone/modules/settings/settings_controller.dart';


class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<SettingsController>(
          () => SettingsController(),
    );
  }
}