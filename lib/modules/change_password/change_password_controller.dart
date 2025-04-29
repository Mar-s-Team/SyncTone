import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangePasswordController extends GetxController {
  final newPasswordC = TextEditingController();
  final confirmPasswordC = TextEditingController();
  final isHidden = true.obs;
  final isLoading = false.obs;

  Future<void> changePassword(AppLocalizations authStrings) async {
    if (newPasswordC.text != confirmPasswordC.text) {
      showDialog(
        context: Get.context!,
        builder: (_) => AlertDialog(
          title: Text(authStrings.changePasswordErrorTitle),
          content: Text(authStrings.changePasswordErrorMismatch),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(authStrings.changePasswordDialogOk),
            ),
          ],
        ),
      );
      return;
    }

    if (newPasswordC.text.isEmpty) {
      showDialog(
        context: Get.context!,
        builder: (_) => AlertDialog(
          title: Text(authStrings.changePasswordErrorTitle),
          content: Text(authStrings.changePasswordErrorEmpty),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(authStrings.changePasswordDialogOk),
            ),
          ],
        ),
      );
      return;
    }

    try {
      isLoading.value = true;
      await Supabase.instance.client.auth
          .updateUser(UserAttributes(password: newPasswordC.text));
      isLoading.value = false;

      showDialog(
        context: Get.context!,
        builder: (_) => AlertDialog(
          title: Text(authStrings.changePasswordSuccessTitle),
          content: Text(authStrings.changePasswordSuccessMessage),
          actions: [
            TextButton(
              onPressed: () => Get.back(closeOverlays: true),
              child: Text(authStrings.changePasswordDialogOk),
            ),
          ],
        ),
      );
    } catch (e) {
      isLoading.value = false;
      showDialog(
        context: Get.context!,
        builder: (_) => AlertDialog(
          title: Text(authStrings.changePasswordErrorTitle),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(authStrings.changePasswordDialogOk),
            ),
          ],
        ),
      );
    }
  }
}
