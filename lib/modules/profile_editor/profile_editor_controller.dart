import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileEditorController extends GetxController {
  final nameController            = TextEditingController();
  final lastNameController        = TextEditingController();
  final usernameController        = TextEditingController();
  //final spotifyUsernameController = TextEditingController();

  final genres = <String>[].obs;
  final selectedGenres = <String>{}.obs;

  final client = Supabase.instance.client;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    loadGenres();
  }

  void toggleGenre(String genre) {
    selectedGenres.contains(genre)
        ? selectedGenres.remove(genre)
        : selectedGenres.add(genre);
  }

  Future<void> saveProfile() async {
    final user = client.auth.currentUser;
    if (user == null) return;

    // UPDATE user profile data
    final updateResponse = await client
        .from('users')
        .update({
      'first_name': nameController.text,
      'last_name': lastNameController.text,
      'username': usernameController.text,
      //'spotify_username': spotifyUsernameController.text,
    })
        .eq('id_user', user.id);

    print("User update response: $updateResponse");
  }



  Future<void> loadUserData() async {
    final user = client.auth.currentUser;
    if (user == null) return;
    else{print("HOLA");}

    final data = await client
        .from('users')
        .select('first_name, last_name, username')
        .eq('id_user', user.id)
        .single();
    print("Datos recibidos: $data");
    nameController.text            = data['first_name'] ?? '';
    lastNameController.text        = data['last_name'] ?? '';
    usernameController.text        = data['username'] ?? '';
  }
  // DEBUG

  Future<void> loadGenres() async {
    try {
      final response = await Supabase.instance.client
          .from('genres')
          .select('name');

      print('Géneros recibidos: $response');

      final genreNames = List<String>.from(response.map((e) => e['name']));
      genres.assignAll(genreNames);
    } catch (error) {
      print('Error al cargar géneros: $error');
    }
  }

  @override
  void onClose() {
    //nameController.dispose();
    //lastNameController.dispose();
    //usernameController.dispose();
    //spotifyUsernameController.dispose();
    super.onClose();
  }
}
