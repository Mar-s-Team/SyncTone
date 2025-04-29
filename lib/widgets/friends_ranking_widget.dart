import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctone/models/user_model.dart';
import 'package:synctone/routes/app_pages.dart';

import '../controllers/auth_controller.dart';

class FriendsRanking extends StatelessWidget {
  const FriendsRanking({
    required this.rank,
    required this.friend,
    super.key,
  });
  final UserModel friend;
  final int rank;

  @override
    Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
      return Column(
        children: [
          CircleAvatar(
            radius: rank == 1 ? 50 : rank == 2 ? 40 : 40,
            backgroundImage: friend.userImage != null && friend.userImage != ''
                ? NetworkImage(friend.userImage ?? '')
                : const AssetImage('assets/avatar_placeholder.png') as ImageProvider,
          ),
          const SizedBox(height: 4),
          Text(friend.username, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 2),
          Icon(
            Icons.emoji_events,
            size: 32,
            color: rank == 1
                ? Colors.amber
                : rank == 2
                ? Colors.grey
                : Colors.brown,
          ),
        ],
      );
    }
}