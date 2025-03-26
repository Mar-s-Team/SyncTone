import 'package:flutter/material.dart';
import 'package:synctone/widgets/settings_menu_widget.dart';

class RegisterScreen extends StatelessWidget {

  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My SyncFriends'),
          leading: const SettingsMenuWidget(),
        ),
        body: Container(
         )
    );
  }
}