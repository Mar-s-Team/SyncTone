import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../../widgets/settings_menu_widget.dart';
import 'location_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationScreen extends StatelessWidget {
  final LocationController controller = Get.put(LocationController());
  LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.locationsTitle),
        leading: const SettingsMenuWidget(),
      ),
      body: FlutterMap(
        mapController: controller.mapController,
        options: MapOptions(
          center: controller.initialPosition,
          zoom: controller.initialZoom,
          minZoom: 1,
          maxZoom: 19,
          interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.marsteam.synctone',
            minZoom: 1,
            maxZoom: 19,
          ),
          Obx(() => MarkerLayer(
            markers: [
              Marker(
                point: controller.realTimePosition.value,
                width: 50,
                height: 50,
                builder: (ctx) => const Icon(
                  Icons.my_location,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
              ...controller.markers,
            ],
          )),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.my_location, color: Colors.black),
                  onPressed: () => controller.moveCamera(controller.realTimePosition(), 18.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}