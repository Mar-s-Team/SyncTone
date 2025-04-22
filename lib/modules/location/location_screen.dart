import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'location_controller.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late GoogleMapController _mapController;
  final LocationController _locationController = Get.put(LocationController());

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(41.3784, 2.1925), // Coordenadas de Barcelona (predeterminadas)
    zoom: 12,
  );

  // Lista de marcadores predefinidos
  final Set<Marker> markers = {
    const Marker(
      markerId: MarkerId('song1'),
      position: LatLng(41.3784, 2.1925), // Marcador en el centro de Barcelona
      infoWindow: InfoWindow(
        title: 'Canción 1',
        snippet: 'Javi todavía no he podido jugar TLOU2 =C',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ),
    const Marker(
      markerId: MarkerId('song2'),
      position: LatLng(41.3800, 2.1935), // Otra ubicación cerca de Barcelona
      infoWindow: InfoWindow(
        title: 'Canción 2',
        snippet: 'Descripción de la Canción 2',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ),
    const Marker(
      markerId: MarkerId('song3'),
      position: LatLng(41.3760, 2.1885), // Otra ubicación en Barcelona
      infoWindow: InfoWindow(
        title: 'Canción 3',
        snippet: 'Descripción de la Canción 3',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.locationsTitle),
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPosition, // Configura la cámara inicial
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
          _goToUserLocation(); // Llamar a la función después de que se cree el mapa
        },
        mapType: MapType.normal,
        markers: markers,
        myLocationEnabled: true, // Permite la ubicación actual
        myLocationButtonEnabled: true, // Activa el botón de ubicación
      ),
    );
  }

  Future<void> _goToUserLocation() async {
    try {
      // Obtén la ubicación actual del usuario
      final position = await _locationController.determinePosition();

      // Verifica que las coordenadas obtenidas sean correctas
      print("Ubicación actual: Lat: ${position.latitude}, Lon: ${position.longitude}");

      final LatLng userLatLng = LatLng(position.latitude, position.longitude);

      // Asegúrate de que _mapController esté inicializado antes de usarlo
      // Mueve la cámara al lugar del usuario
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: userLatLng, zoom: 15),
        ),
      );
        } catch (e) {
      print('Error obteniendo ubicación: $e');
    }
  }
}
