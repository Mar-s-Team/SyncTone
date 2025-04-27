import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/song_map.dart';

class LocationController extends GetxController {
  late MapController mapController;
  SupabaseClient client = Supabase.instance.client;
  final initialPosition = const LatLng(41.35934969449732, 2.076988185642747); // Mercadona
  final initialPosition2 = const LatLng(41.36098285791049, 2.079028340233199); // Gestoria
  final sarriaPosition = const LatLng(41.39493743803288, 2.1275733516533615); // Salesians de Sarria
  final double initialZoom = 14.0;
  final markers = <Marker>{}.obs;
  Rx<LatLng> realTimePosition = Rx<LatLng>(const LatLng(40.4168, -3.7038));
  final double markerRadius = 1000.0;

  @override
  void onInit() {
    super.onInit();
    mapController = MapController();
    _startLocationUpdates();
    fetchMarkers();
  }
  Future<void> fetchMarkers() async {
    final response = await client.from('map_songs').select();
    if (response.isEmpty) {
      print('No hay marcadores en Supabase.');
      return;
    }
    markers.clear();
    print('Marcadores obtenidos de Supabase: $response');

    for (final data in response) {
      final markerModel = SongMap.fromJson(data);
      markers.add(
        Marker(
          point: LatLng(markerModel.latitude, markerModel.longitude),
          width: 80,
          height: 80,
          builder: (ctx) => GestureDetector(
            onTap: () {
              print('Clicaste en: ${markerModel.title}');
            },
            child: const Icon(
              Icons.location_on,
              color: Colors.red,
              size: 40,
            ),
          ),
        ),
      );
    }
    markers.refresh();
  }
  // Función para iniciar la actualización de ubicación en tiempo real
  void _startLocationUpdates() async {
    // Verificar si el servicio de ubicación está habilitado
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Mostrar mensaje al usuario para activar el servicio de ubicación
      return;
    }
    // Verificar si el permiso de ubicación es denegado
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Mostrar mensaje al usuario para permitir el permiso
        return;
      }
    }
    // Verificar si el permiso de ubicación está permanentemente denegado
    if (permission == LocationPermission.deniedForever) {
      // Dirigir al usuario a la configuración para habilitar manualmente el permiso
      _openLocationSettings();
      return;
    }
    // Continuar con la obtención de la ubicación en tiempo real
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
      final newPos = LatLng(position.latitude, position.longitude);
      realTimePosition.value = newPos;
    });
  }
  // Abrir la configuración de ubicación para que el usuario habilite los permisos manualmente
  void _openLocationSettings() {
    Geolocator.openLocationSettings();
  }
  // Función para manejar el evento onTap del marcador
  void _handleMarkerTap(BuildContext context, LatLng markerPosition) {
    // Calcular la distancia entre la ubicación del usuario y el marcador
    double distance = Geolocator.distanceBetween(
      realTimePosition.value.latitude,
      realTimePosition.value.longitude,
      markerPosition.latitude,
      markerPosition.longitude,
    );
    print(distance);
    // Si la distancia es menor o igual al radio de acción, activamos el evento onTap
    if (distance <= markerRadius) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Ubicación clicada dentro del radio!')),
      );
    } else {
      // Si no está dentro del radio lo indica
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Estás fuera del radio del marcador')),
      );
    }
  }
  void moveCamera(LatLng position, [double zoom = 14.0]) {
    mapController.move(position, zoom);
  }
}