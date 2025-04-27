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

  FriendsController(){
    loadData();
  }

  void loadData()  {
    getFriends();
    getTopFriends();
  }

  Future<void> showQRInputDialog(BuildContext context) async {
    TextEditingController qrController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // Permite cerrar el diálogo tocando fuera
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Introducir código QR'), // Título del diálogo
          content: TextField(
            controller: qrController,
            decoration: const InputDecoration(
              hintText: 'Introduce el código QR', // Indicación para el usuario
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                // Procesamos el código QR ingresado
                String qrCode = qrController.text;
                print('Código QR ingresado: $qrCode');

                final user = client.auth.currentUser;
                if (user == null) {
                  print("Error: No hay usuario autenticado");
                  return;
                }
                try {
                  // Actualizamos la base de datos en Supabase
                  await client.from("friendships").insert({
                    "id_friend": qrCode, // Guardamos el código QR como nombre de usuario
                    "created_at": DateTime.now().toIso8601String(),
                    "id_user": user.id});

                  print("Invitación enviada correctamente");
                } catch (e) {
                  print("Error al enviar la invitación: $e");
                }
                Navigator.of(context).pop(); // Cerramos el diálogo
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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