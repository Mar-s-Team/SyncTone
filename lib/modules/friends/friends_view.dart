import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctone/modules/friends/friends_controller.dart';

class FriendsView extends GetView<FriendsController> {

  const FriendsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
          title: const Text('Login'),
           centerTitle: true,
         ),
         );
  }
}