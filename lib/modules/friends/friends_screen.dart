import 'package:flutter/material.dart';
import 'package:synctone/widgets/settings_menu_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../models/user_model.dart';
import '../../widgets/friends_ranking_widget.dart';
import '../settings/qr_code_scanner.dart';
import '../friends/friends_controller.dart';
import 'package:synctone/widgets/friend_card_widget.dart';
import 'package:synctone/widgets/friend_search_widget.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  FriendsController controller = FriendsController();

  @override
  Widget build(BuildContext context) {
    controller.loadData();
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
              FriendSearchBar(
                allFriends: controller.allFriends,
                onSearch: (results) {
                setState(() {
                  controller.filteredFriends = results;
                });
              },
            ),
            const SizedBox(height: 12),
            const Text("Top SyncFriends", style: TextStyle(fontSize: 18, color: Colors.white)),
            const SizedBox(height: 10),
              SizedBox(
                height: 190,
                child: controller.topFriends.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    if (controller.topFriends.length > 1)
                      Positioned(
                        left: 50,
                        top: 50,
                        child: FriendsRanking(rank: 2, friend: controller.topFriends[1]),
                      ),
                    if (controller.topFriends.isNotEmpty)
                      Positioned(
                        top: 0,
                        child: FriendsRanking(rank: 1, friend: controller.topFriends[0]),
                      ),
                    if (controller.topFriends.length > 2)
                      Positioned(
                        right: 50,
                        top: 50,
                        child: FriendsRanking(rank: 3, friend: controller.topFriends[2]),
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
                      await controller.showQRInputDialog(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: controller.filteredFriends.isEmpty
                    ? const Center(child: Text("No friends found"))
                    : ListView.builder(
                  itemCount: controller.filteredFriends.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: UserCard(friend: controller.filteredFriends[index]),
                    );
                  },
                ),
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
