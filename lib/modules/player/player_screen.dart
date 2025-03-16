import 'package:flutter/material.dart';
import 'package:synctone/widgets/settings_menu_widget.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Currently playing'),
          leading: const SettingsMenuWidget(),
        ),
        body: Container(
         )
    );
  }
}