import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:synctone/widgets/settings_menu_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../models/user_model.dart';
import '../../widgets/friends_ranking_widget.dart';
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
  List<UserModel> topFriends = [];
  List<UserModel> allFriends = [];
  List<UserModel> filteredFriends = [];

  @override
  void initState() {
    super.initState();
    controller.getTopFriends().then((data) {
      setState(() {
        topFriends = data.map((friendMap) {
          final user = friendMap['users'] ?? {};
          return UserModel.fromJson(user);
        }).toList();
      });
    });

    controller.getFriends().then((data) {
      setState(() {
        allFriends = data.map((friendMap) {
          final user = friendMap['users'] ?? {};
          return UserModel.fromJson(user);
        }).toList();
        filteredFriends = allFriends;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.friendsTitle),
        leading: const SettingsMenuWidget(),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FriendSearchBar(
                  allFriends: allFriends,
                  onSearch: (results) {
                    setState(() {
                      filteredFriends = results;
                    });
                  },
                ),
                const SizedBox(height: 12),
                Text(AppLocalizations.of(context)!.topFriends, style: const TextStyle(fontSize: 18, color: Colors.white)),
                const SizedBox(height: 10),
                SizedBox(
                  height: 190,
                  child: topFriends.isEmpty
                      ? const Center(
                    child: Text(
                      "No friends yet",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                      : Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      if (topFriends.length > 1)
                        Positioned(
                          left: 50,
                          top: 50,
                          child: FriendsRanking(rank: 2, friend: topFriends[1]),
                        ),
                      if (topFriends.isNotEmpty)
                        Positioned(
                          top: 0,
                          child: FriendsRanking(rank: 1, friend: topFriends[0]),
                        ),
                      if (topFriends.length > 2)
                        Positioned(
                          right: 50,
                          top: 50,
                          child: FriendsRanking(rank: 3, friend: topFriends[2]),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.myFriends, style: const TextStyle(fontSize: 18, color: Colors.white)),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.white, size: 30),
                      onPressed: () {
                        controller.startScanning();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: filteredFriends.isEmpty
                      ? Center(child: Text(AppLocalizations.of(context)!.noFriends, style: TextStyle(color: Colors.white)))
                      : ListView.builder(
                    itemCount: filteredFriends.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: UserCard(friend: filteredFriends[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            if (!controller.isScanning.value) return const SizedBox.shrink();
            return Container(
              color: Colors.black.withOpacity(0.8),
              child: Column(
                children: [
                  Expanded(
                    child: MobileScanner(
                      onDetect: (BarcodeCapture capture) {
                        final List<Barcode> barcodes = capture.barcodes;
                        if (barcodes.isNotEmpty) {
                          final String? code = barcodes.first.rawValue;
                          if (code != null) {
                            controller.processQrCode(code);
                          }
                        }
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.stopScanning();
                    },
                    child: Text(AppLocalizations.of(context)!.cancelScanning),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
