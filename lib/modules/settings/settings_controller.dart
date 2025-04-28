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
  var userImage = Rx<String?>(null);

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
      // Llama al método para subir la imagen y actualizar la URL
      _uploadImage(File(pickedFile.path));
    }
  }
  Future<void> _uploadImage(File image) async {
    final supabase = Supabase.instance.client;
    final fileName = 'avatars/${DateTime.now().millisecondsSinceEpoch}.png'; // Nombre único para la imagen
    final storage = supabase.storage.from('user-images'); // Asumiendo que tienes un bucket llamado 'avatars'

    try {
      // Subir el archivo
      final response = await storage.upload(fileName, image);
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
      final response = await supabase.from('users').update({
        'user_image': imageUrl,
      }).eq('id_user', userId);

      if (response.error == null) {
        print('Imagen actualizada correctamente');

        // Actualizamos la URL de la imagen en el observable
        authC.loggedUser?.userImage = imageUrl;  // Aquí actualizamos el valor
      } else {
        print('Error al actualizar la imagen: ${response.error?.message}');
      }
    }
  }
}
