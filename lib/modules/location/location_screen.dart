import 'package:flutter/material.dart';
import 'package:synctone/widgets/settings_menu_widget.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My SyncLocations'),
          leading: const SettingsMenuWidget(),
        ),
        body: Container(
         )
    );
  }
}