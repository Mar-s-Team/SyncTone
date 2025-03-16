import 'package:flutter/material.dart';
import 'package:synctone/widgets/settings_menu_widget.dart';

class PlaylistsScreen extends StatelessWidget {
  const PlaylistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My SyncPlaylists'),
          leading: const SettingsMenuWidget(),
        ),
        body: Container(
         )
    );
  }
}