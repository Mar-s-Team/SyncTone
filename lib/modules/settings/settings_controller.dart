import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SettingsController extends GetxController {
  Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }
}
