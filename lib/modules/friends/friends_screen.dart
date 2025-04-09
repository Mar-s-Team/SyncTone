import 'package:flutter/material.dart';
import 'package:synctone/widgets/settings_menu_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../settings/qr_code_scanner.dart';
import '../friends/friends_controller.dart';
import 'package:synctone/widgets/friend_card_widget.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildTopUser(String name, String rank, String imageUrl, {double size = 30}) {
      int rankNumber = int.parse(rank.replaceAll("🏆", ""));
      return Column(
        children: [
          CircleAvatar(
            radius: size,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 4),
          Text(name, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 2),
          Icon(
            Icons.emoji_events,
            size: 32,
            color: rankNumber == 1
                ? Colors.amber
                : rankNumber == 2
                ? Colors.grey
                : Colors.brown,
          ),
        ],
      );
    }
    final FriendsController friendsController = FriendsController();
    List<UserCard> friends = [];

    friendsController.getFriends();
    friendsController.getTopFriends();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.friendsTitle),
        leading: const SettingsMenuWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text("Top SyncFriends", style: TextStyle(fontSize: 18, color: Colors.white)),
            const SizedBox(height: 10),
              SizedBox(
                height: 180,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      left: 265,
                      top: 50,
                      child: buildTopUser("Javier Márquez", "🏆2", "https://via.placeholder.com/150"),
                    ),
                    Positioned(
                      top: 0,
                      child: buildTopUser("Javier Martín", "🏆1", "https://via.placeholder.com/150", size: 45),
                    ),
                    Positioned(
                      right: 265,
                      top: 50,
                      child: buildTopUser("Sandra Martos", "🏆3", "https://via.placeholder.com/150"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("My Syncfriends", style: TextStyle(fontSize: 18, color: Colors.white)),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.white, size: 30),
                    onPressed: () async {
                      await friendsController.showQRInputDialog(context);
                    },
                  ),
                ],
              ),
        /*
        child: ElevatedButton(
          onPressed: () async {
            // Usamos el controlador para mostrar el diálogo
            await friendsController.showQRInputDialog(context);
          },
          child: const Text("Introducir código QR"),

        ),
        */
            ]
        ),
      ),
    );
  }
}
