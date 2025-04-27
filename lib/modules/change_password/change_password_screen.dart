import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'change_password_controller.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authStrings = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          authStrings.settingsChangePassword,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 375,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Text(
                authStrings.settingsChangePassword,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 300,
                child: Obx(() => TextField(
                  controller: controller.newPasswordC,
                  obscureText: controller.isHidden.value,
                  decoration: InputDecoration(
                    labelText: authStrings.newPasswordLabel,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => controller.isHidden.toggle(),
                      icon: Icon(controller.isHidden.isTrue
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                )),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: Obx(() => TextField(
                  controller: controller.confirmPasswordC,
                  obscureText: controller.isHidden.value,
                  decoration: InputDecoration(
                    labelText: authStrings.confirmNewPasswordLabel,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                )),
              ),
              const SizedBox(height: 40),
              Obx(() => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.changePassword();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: controller.isLoading.isFalse
                    ? Text(authStrings.settingsChangePassword)
                    : const CircularProgressIndicator(color: Colors.white),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
