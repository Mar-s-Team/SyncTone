import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctone/controllers/auth_controller.dart';
import 'package:synctone/modules/qr_scanner/qr_scanner_binding.dart';
import 'package:synctone/modules/qr_scanner/qr_scanner_screen.dart';
import 'package:synctone/routes/app_pages.dart';
import 'settings_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
    //controller.generateQR();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.offAllNamed(Routes.MAIN),
              ),
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: controller.pickImage, // Método para seleccionar la imagen
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(
                              (authC.loggedUser?.userImage?.isNotEmpty ?? false)
                                  ? authC.loggedUser!.userImage
                                  : 'https://cdn-icons-png.freepik.com/512/8211/8211048.png',
                            ),
                          ),
                          const Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.purple,
                              child: Icon(Icons.edit, size: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      authC.loggedUser?.username ?? '',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      authC.client.auth.currentUser?.email ?? '',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _quickActions(context),
              const SizedBox(height: 20),
              _settingsPanel(context, authC),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _quickAction(
            Icons.music_note,
            "Spotify",
                () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color(0xFF1C1C1C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  title: const Text(
                    "Spotify",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                  content: Text(
                    AppLocalizations.of(context)!.comingSoonMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cerrar', style: TextStyle(color: Colors.purple)),
                    ),
                  ],
                ),
              );
            },
          ),
          _quickAction(
            Icons.notifications,
            AppLocalizations.of(context)!.settingsNotifications,
                () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color(0xFF1C1C1C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  title: Text(
                    AppLocalizations.of(context)!.settingsNotifications,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                  content: Text(
                    AppLocalizations.of(context)!.comingSoonMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cerrar', style: TextStyle(color: Colors.purple)),
                    ),
                  ],
                ),
              );
            },
          ),

          _quickAction(
            Icons.help_outline,
            AppLocalizations.of(context)!.settingsContact,
                () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color(0xFF1C1C1C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  title: Text(
                    AppLocalizations.of(context)!.settingsContact,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),

                  content: Text(
                    AppLocalizations.of(context)!.settingsContactDialog,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cerrar', style: TextStyle(color: Colors.purple)),
                    ),
                  ],
                ),
              );
            },
          ),

        ],
      ),
    );
  }

  Widget _settingsPanel(BuildContext context, AuthController authC) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.settingsTitle,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 16),
          _languageSelector(context),
          /*Obx(() => _settingSwitch(
            Icons.dark_mode,
            AppLocalizations.of(context)!.settingsDarkMode,
            controller.isDarkMode.value,
            controller.toggleDarkMode,
          )),*/
          _settingItem(
            Icons.person,
            AppLocalizations.of(context)!.settingsProfileSettings,
            trailingText: AppLocalizations.of(context)!.settingsProfileSettingsMini,
            onTap: () => Get.offAllNamed(Routes.PROFILEEDITOR),
          ),
          _settingItem(
            Icons.qr_code,
            AppLocalizations.of(context)!.settingsMyQRCode,
            onTap: () async {
              await controller.generateQR();
              Get.dialog(
                AlertDialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  title: Text(AppLocalizations.of(context)!.settingsMyQRCode,  textAlign: TextAlign.center, style: const TextStyle(color: Colors.black)),
                  content: Obx(
                    () => SizedBox(
                      width: 250,
                      height: 250,
                      child: controller.qrCodeWidget.value,
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () => Get.back(),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.black,
                            side: const BorderSide(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child:
                            Text(AppLocalizations.of(context)!.settingsMyQRCodeClose,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          /*
          _settingItem(Icons.lock, AppLocalizations.of(context)!.settingsChangePassword, onTap: () {}),
              final scannedCode = await Get.to(() => const QRScannerScreen(), binding: QRScannerBinding());
              if (scannedCode != null) {
                debugPrint('Código escaneado: $scannedCode');
              }
            },
          ),
*/
          _settingItem(
            Icons.lock,
            AppLocalizations.of(context)!.settingsChangePassword,
            onTap: () => Get.toNamed(Routes.CHANGEPASSWORD),
          ),
          const Divider(color: Colors.white24, height: 32),
          _settingItem(
            Icons.logout,
            AppLocalizations.of(context)!.settingsLogout,
            trailingText: AppLocalizations.of(context)!.settingsLogoutMini,
            onTap: authC.logout,
          ),
        ],
      ),
    );
  }
  Widget _languageSelector(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.language, color: Colors.purple),
          const SizedBox(width: 16),
          Expanded(
            child: DropdownButtonFormField<String>(
              dropdownColor: const Color(0xFF1C1C1C),
              style: const TextStyle(color: Colors.white),
              iconEnabledColor: Colors.white70,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.settingsLanguage,
                labelStyle: const TextStyle(color: Colors.white),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
              ),
              items: [
                DropdownMenuItem(value: 'es', child: Text(AppLocalizations.of(context)!.settingsLanguageEsp)),
                DropdownMenuItem(value: 'en', child: Text(AppLocalizations.of(context)!.settingsLanguageEng)),
                DropdownMenuItem(value: 'ca', child: Text(AppLocalizations.of(context)!.settingsLanguageCat)),
              ],
              onChanged: (val) {
                if (val != null) {
                  Get.updateLocale(Locale(val));
                }
              },
            ),
          ),
        ],
      ),
    );
  }



  Widget _quickAction(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: IconButton(icon: Icon(icon, color: Colors.black), onPressed: onPressed),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _settingItem(IconData icon, String title, {String? trailingText, VoidCallback? onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.purple),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: trailingText != null
          ? Text(trailingText, style: const TextStyle(color: Colors.white70))
          : const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
      onTap: onTap,
    );
  }

  Widget _settingSwitch(IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.purple),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.purple,
      ),
    );
  }
}
