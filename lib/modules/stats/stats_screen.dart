import 'package:flutter/material.dart';
import 'package:synctone/widgets/settings_menu_widget.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My SyncStats'),
          leading: const SettingsMenuWidget(),
        ),
        body: Container(
         )
    );
  }
}