import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  late MapController mapController;

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
    _addUserLocationMarker();
    _startLocationUpdates();
  }
  void _addUserLocationMarker() {
    markers.add(
        Marker(
          point: initialPosition,
          width: 80,
          height: 80,
          builder: (ctx) => GestureDetector(
            onTap: () {
                  _handleMarkerTap(ctx, initialPosition);
            },
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, color: Colors.red, size: 40),
                SizedBox(height: 4),
                Text(
                  'Barcelona',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
    markers.add(
        Marker(
          point: initialPosition2,
          width: 80,
          height: 80,
          builder: (ctx) => GestureDetector(
            onTap: () {
              _handleMarkerTap(ctx, initialPosition2);
            },
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, color: Colors.red, size: 40),
                SizedBox(height: 4),
                Text(
                  'Barcelona2',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
    markers.add(
      Marker(
        point: sarriaPosition,
        width: 80,
        height: 80,
        builder: (ctx) => GestureDetector(
          onTap: () {
            _handleMarkerTap(ctx, sarriaPosition
            );
          },
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on, color: Colors.red, size: 40),
              SizedBox(height: 4),
              Text(
                'Salesians Sarria',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
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