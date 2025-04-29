import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../controllers/auth_controller.dart';

class SettingsController extends GetxController {
  Rx<Widget> qrCodeWidget = Rx<Widget>(Container());
  var userImage = ''.obs;

  final defaultImageUrl = 'https://cdn-icons-png.freepik.com/512/8211/8211048.png';

  @override
  void onInit() {
    super.onInit();
    fetchUserImage();
  }

  Future<void> fetchUserImage() async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;

    if (userId != null) {
      final response = await supabase
          .from('users')
          .select('user_image')
          .eq('id_user', userId)
          .maybeSingle();

      if (response != null && response['user_image'] != null) {
        userImage.value = response['user_image'] as String;
      } else {
        userImage.value = defaultImageUrl;
      }
    }
  }

  Future<void> generateQR() async {
    final client = Supabase.instance.client;
    final user = client.auth.currentUser;

    if (user == null) return;

    final response = await client
        .from('users')
        .select('id_user')
        .eq('id_user', user.id)
        .single();

    final qrData = response['id_user'].toString();

    qrCodeWidget.value = QrImageView(
      data: qrData,
      version: QrVersions.auto,
      size: 250.0,
      errorCorrectionLevel: QrErrorCorrectLevel.H,
      backgroundColor: Colors.white,
      eyeStyle: const QrEyeStyle(
        eyeShape: QrEyeShape.square,
        color: Colors.black,
      ),
      dataModuleStyle: const QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square,
        color: Colors.black,
      ),
    );
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      await _uploadImage(File(pickedFile.path));
    }
  }

  void updateUserImage(String newImageUrl) {
    userImage.value = newImageUrl;
  }

  Future<void> _uploadImage(File image) async {
    final supabase = Supabase.instance.client;
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final storage = supabase.storage.from('user-images');

    try {
      final bytes = await image.readAsBytes();
      final response = await storage.uploadBinary(fileName, bytes);
      print('Respuesta: $response');
      final imageUrl = storage.getPublicUrl(fileName);
      print('URL de la imagen: $imageUrl');
      await _updateProfileImageUrl(imageUrl);
    } catch (e) {
      print('Error al subir la imagen: $e');
    }
  }

  Future<void> _updateProfileImageUrl(String imageUrl) async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;
    final authC = Get.find<AuthController>();

    if (userId != null) {
      try {
        final response = await supabase
            .from('users')
            .update({'user_image': imageUrl})
            .eq('id_user', userId);
        print('Respuesta al actualizar imagen: $response');

        authC.loggedUser?.userImage = imageUrl;
        updateUserImage(imageUrl);
      } catch (e) {
        print('Error al actualizar la imagen: $e');
      }
    }
  }
}
