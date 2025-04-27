import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synctone/controllers/auth_controller.dart';
import 'package:synctone/models/user_model.dart';

class FriendsController extends GetxController {
  AuthController authC = Get.find<AuthController>();

  SupabaseClient client = Supabase.instance.client;
  UserModel? loggedUser;

  List<UserModel> allFriends = [];
  List<UserModel> topFriends = [];
  List<UserModel> filteredFriends = [];
  RxBool isScanning = false.obs;

  FriendsController(){
    loadData();
  }
  void loadData()  {
    getFriends();
    getTopFriends();
  }
  void startScanning() {
    isScanning.value = true;
  }
  void stopScanning() {
    isScanning.value = false;
  }
  void processQrCode(String qrCode) {
    print("Código QR detectado: $qrCode");
    // Lógica para agregar amigo, por ejemplo:
    addFriendByQr(qrCode);
    stopScanning();
  }
  void addFriendByQr(String qrCode) async {
    // Aquí va la lógica para agregar el amigo usando el código QR
    try {
      final user = client.auth.currentUser;
      if (user == null) {
        print("Error: No hay usuario autenticado");
        return;
      }
      await client.from("friendships").insert({
        "id_friend": qrCode, // Guardamos el código QR como nombre de usuario
        "created_at": DateTime.now().toIso8601String(),
        "id_user": user.id
      });
      print("Amigo agregado correctamente");
    } catch (e) {
      print("Error al agregar el amigo: $e");
    }
  }
  void getFriends() async {
    try {
      final response = await client.from('friendships')
          .select('users!id_friend(*)') // Relación con users
          .eq('id_user', client.auth.currentUser!.id); // Amigos del usuario autentificado

      allFriends = response.map((friendMap) {
        final user = friendMap['users'] ?? {};
          return UserModel.fromJson(user);
        }).toList();
      filteredFriends = allFriends;

    } catch (e) {
      print("Error al recuperar amigos: $e");
    }
  }

  void getTopFriends() async {
    try {
      final response = await client.from('friendships')
          .select('users!id_friend(*)') // Relación con users
          .eq('id_user',client.auth.currentUser!.id) // Amigos del usuario autentificado
          .order('compatibility', ascending: false)
          .limit(3);
      topFriends = response.map((friendMap) {
        final user = friendMap['users'] ?? {};
        return UserModel.fromJson(user);
      }).toList();
    } catch (e) {
      print("Error: $e");
    }
  }

}