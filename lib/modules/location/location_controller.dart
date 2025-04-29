import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synctone/api/api_service.dart';
import 'package:synctone/controllers/bottom_navigator_controller.dart';
import 'package:synctone/modules/main/main_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../models/song_map.dart';

class LocationController extends GetxController {
  late MapController mapController;
  late MainController controller;
  late BottomNavigatorController navC;
  SupabaseClient client = Supabase.instance.client;
  final initialPosition = const LatLng(40.4168, -3.7038);
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
              _handleMarkerTap(ctx, LatLng(markerModel.latitude, markerModel.longitude), markerModel.id, markerModel.title);
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
  void _handleMarkerTap(BuildContext context, LatLng markerPosition, String id, String title) {
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
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(20), // Añadir padding para más espacio en el contenido
            title: Center(
              child: Text(
                '🎶 $title 🎶',
                textAlign: TextAlign.center,
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                AppLocalizations.of(context)!.locationReproduce,
                textAlign: TextAlign.center,
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final track = await ApiService.getTrackById(id);
                      if (track != null) {
                        controller.currentSong.value = track;
                        navC.setIndex(2);
                      }
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.play_arrow, color: Colors.white),
                    label: Text(
                      AppLocalizations.of(context)!.locationPlay,
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black),
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.locationCancel,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
      //controller.currentSong.value = ApiService.getTrackById(id) as Track;
      //navC.setIndex(2);
    } else {
      // Si no está dentro del radio lo indica
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.locationOutOfRange)),
      );
    }
  }
  void moveCamera(LatLng position, [double zoom = 14.0]) {
    mapController.move(position, zoom);
  }
}