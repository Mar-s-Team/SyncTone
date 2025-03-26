import 'package:flutter/material.dart';
import 'package:synctone/widgets/settings_menu_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FriendsScreen extends StatelessWidget {

  const FriendsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.friendsTitle),
          leading: const SettingsMenuWidget(),
        ),
        body: Container(
         )
    );
  }
}