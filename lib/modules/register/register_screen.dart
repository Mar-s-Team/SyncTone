import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctone/routes/app_pages.dart';
import 'register_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 375,
                height: 450,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
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
                  children: [
                    Text(AppLocalizations.of(context)!.registerTitle,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        autocorrect: false,
                        controller: controller.emailC,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.registerEmailLabel,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      child: Obx(() => TextField(
                        autocorrect: false,
                        controller: controller.passwordC,
                        textInputAction: TextInputAction.done,
                        obscureText: controller.isHidden.value,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () => controller.isHidden.toggle(),
                              icon: controller.isHidden.isTrue
                                  ? const Icon(Icons.remove_red_eye)
                                  : const Icon(Icons.remove_red_eye_outlined)),
                          labelText: AppLocalizations.of(context)!.registerPasswordLabel,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      )),
                    ),
                    const SizedBox(height: 20),
                    Obx(() => ElevatedButton(
                      onPressed: () async {
                        if (controller.isLoading.isFalse) {
                          bool? cekAutoLogout = await controller.register();
                          if (cekAutoLogout != null && cekAutoLogout == true) {
                            Get.offAllNamed(Routes.LOGIN);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 107),
                      ),
                      child: Text(controller.isLoading.isFalse ?
                      AppLocalizations.of(context)!.registerSignUpButton : AppLocalizations.of(context)!.loginButtonLoading),
                    )),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Expanded(child: Divider(thickness: 3)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            AppLocalizations.of(context)!.loginOtherLabel,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Expanded(child: Divider(thickness: 3)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                      },
                      icon: Image.asset('assets/logo_google.jpg', height: 24),
                      label: Text(AppLocalizations.of(context)!.loginGoogleButton),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.black26),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.loginNoAccount),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () => Get.toNamed(Routes.LOGIN),
                          child: Text(AppLocalizations.of(context)!.loginSignUp,
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}