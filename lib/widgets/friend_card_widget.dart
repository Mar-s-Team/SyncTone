import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctone/models/user_model.dart';
import 'package:synctone/routes/app_pages.dart';


class UserCard extends StatelessWidget {
  const UserCard({
    required this.friend,
    super.key,
  });

  final UserModel friend;

  @override
  Widget build(BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(8),
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
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('https://via.placeholder.com/40'),
          ),
          const Spacer(),
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                friend.username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                'user@domainname.com',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {},
            child: const Text('View'),
          ),
        ],
      ),
    );
  }
}
