import 'package:get/get.dart';
import 'package:synctone/modules/profile_editor/profile_editor_controller.dart';

class ProfileEditorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileEditorController>(
            () => ProfileEditorController(),
        fenix: true,);
  }
}

