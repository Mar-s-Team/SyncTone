import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctone/models/user_model.dart';

import '../controllers/auth_controller.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    required this.friend,
    super.key,
  });
  final UserModel friend;

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: friend.userImage != null && friend.userImage != ''
                ? NetworkImage(friend.userImage ?? '')
                : const NetworkImage('https://cdn-icons-png.freepik.com/512/8211/8211048.png')
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                friend.username,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${friend.firstName ?? ''} ${friend.lastName ?? ''}',
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          const Spacer(),
          /*
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4B39EF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {},
            child: const Text('View', style: TextStyle(color: Colors.white)),
           */
        ],
      ),
    );
  }
}
