import 'package:flutter/material.dart';
import 'package:synctone/widgets/settings_menu_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SyncTone'),
        leading: const SettingsMenuWidget(),
      ),
      body: Container(),
    );
  }
}