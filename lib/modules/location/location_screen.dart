import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late GoogleMapController _mapController;

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(41.3784, 2.1925), // Coordenadas de Barcelona
    zoom: 12,
  );

  // Lista de marcadores predefinidos
  final Set<Marker> markers = {
    const Marker(
      markerId: MarkerId('song1'),
      position: LatLng(41.3784, 2.1925), // Marcador en el centro de Barcelona
      infoWindow: InfoWindow(
        title: 'Canción 1',
        snippet: 'Descripción de la Canción 1',
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
      //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
    const Marker(
      markerId: MarkerId('song3'),
      position: LatLng(41.3760, 2.1885), // Otra ubicación en Barcelona
      infoWindow: InfoWindow(
        title: 'Canción 3',
        snippet: 'Descripción de la Canción 3',
      ),
      icon: BitmapDescriptor.defaultMarker,
      //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
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
        onMapCreated: (controller) {
          _mapController = controller;
        },
        mapType: MapType.normal,
        markers: markers,
      ),
    );
  }
}
