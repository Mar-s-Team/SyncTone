import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsController extends GetxController {
  // Usamos Rx<Widget> para poder manipularlo como un Widget en el árbol de widgets
  Rx<Widget> qrCodeWidget = Rx<Widget>(Container()); // Iniciamos con un widget vacío (Container)

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
  Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }
}
