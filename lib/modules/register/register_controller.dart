import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController usernameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  Future<bool?> register() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        AuthResponse res = await client.auth
            .signUp(email: emailC.text, password: passwordC.text,);
        await client.from("users").update({
          "username": usernameC.text,
          "created_at": DateTime.now().toIso8601String(),
          "id_user": res.user!.id,
          }).eq("id_user", res.user!.id);

        isLoading.value = false;

        Get.defaultDialog(
            barrierDismissible: false,
            title: "Successfully registered",
            middleText: "Will be redirected to Login page",
            backgroundColor: Colors.green);
        return true;
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("ERROR", e.toString());
      }
    } else {
      Get.snackbar("ERROR", "Email and password are required");
    }
    return null;
  }
}
