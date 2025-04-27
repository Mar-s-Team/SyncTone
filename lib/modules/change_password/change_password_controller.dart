import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangePasswordController extends GetxController {
  RxBool isHidden = true.obs;
  RxBool isLoading = false.obs;

  TextEditingController newPasswordC = TextEditingController();
  TextEditingController confirmPasswordC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  Future<void> changePassword() async {
    if (newPasswordC.text != confirmPasswordC.text) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    if (newPasswordC.text.isEmpty) {
      Get.snackbar("Error", "New password cannot be empty");
      return;
    }

    try {
      isLoading.value = true;
      await client.auth.updateUser(UserAttributes(password: newPasswordC.text));
      isLoading.value = false;
      Get.back(); // Volver atrás tras cambiarla
      Get.snackbar("Success", "Password changed successfully");
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }
}