import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../controllers/auth_controller.dart';

class SettingsController extends GetxController {
  // Usamos Rx<Widget> para poder manipularlo como un Widget en el árbol de widgets
  Rx<Widget> qrCodeWidget = Rx<Widget>(Container()); // Iniciamos con un widget vacío (Container)
  var userImage = ''.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUserImage(); // Al iniciar el controlador, trae la imagen
  }
  Future<void> fetchUserImage() async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;

    if (userId != null) {
      final response = await supabase
          .from('users')
          .select('user_image')
          .eq('id_user', userId)
          .maybeSingle(); // maybeSingle evita errores si no encuentra nada

      if (response != null && response['user_image'] != null) {
        userImage.value = response['user_image'] as String;
      }
    }
  }

  // Este método obtiene los datos de Supabase y genera el código QR
  Future<void> generateQR() async {
    final client = Supabase.instance.client;
    final user = client.auth.currentUser;

    if (user == null) {
      return;
    }
    final response = await client
        .from('users')
        .select('id_user')
        .eq('id_user', user.id)
        .single();
    // Datos para el QR
    final qrData = response['id_user'].toString();

    qrCodeWidget.value = QrImageView(
      data: qrData,
      version: QrVersions.auto,  // Definimos la versión automática
      size: 250.0,
      errorCorrectionLevel: QrErrorCorrectLevel.H, // Nivel de corrección de errores
      backgroundColor: Colors.white,
      eyeStyle: const QrEyeStyle(
        eyeShape: QrEyeShape.square, // Forma de las esquinas del QR
        color: Colors.black,
      ),
      dataModuleStyle: const QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square, // Forma de los puntos
        color: Colors.black,
      ),
    );
  }
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Llama a la función para subir la imagen
      await _uploadImage(File(pickedFile.path));  // Subir la imagen seleccionada
    }

    if (pickedFile != null) {
      // Llama al método para subir la imagen y actualizar la URL
      _uploadImage(File(pickedFile.path));
    }
  }
  void updateUserImage(String newImageUrl) {
    userImage.value = newImageUrl; // Actualiza el valor
  }
  Future<void> _uploadImage(File image) async {
    final supabase = Supabase.instance.client;
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png'; // Nombre único para la imagen
    final storage = supabase.storage.from('user-images'); // Asumiendo que tienes un bucket llamado 'user-images'

    try {
      // Subir el archivo
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
    final userId = Supabase.instance.client.auth.currentUser?.id;
    final authC = Get.find<AuthController>();

    if (userId != null) {
      try {
        final response = await supabase
            .from('users')
            .update({'user_image': imageUrl})
            .eq('id_user', userId);

        print('Respuesta al actualizar imagen: $response');

        authC.loggedUser?.userImage = imageUrl;
      } catch (e) {
        print('Error al actualizar la imagen: $e');
      }
    }
  }
}
