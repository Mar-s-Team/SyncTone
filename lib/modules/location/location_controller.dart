import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica si el servicio está activado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('La localización está desactivada.');
    }

    // Verifica los permisos
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Permiso denegado');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Permiso denegado permanentemente');
    }
    // Obtén la posición
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
  }
}
