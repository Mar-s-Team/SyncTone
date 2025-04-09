import 'package:flutter/material.dart';
import 'settings_controller.dart';
import 'package:get/get.dart';
import 'package:synctone/controllers/auth_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:synctone/routes/app_pages.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  String _selectedLanguage = 'esp'; // Valor por defecto
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Get.offAllNamed(Routes.MAIN),
                ),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundImage: AssetImage('assets/avatar_placeholder.png'),
                          ),
                          Positioned(
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
                      SizedBox(height: 10),
                      Text("Usuario Prueba", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                      Text("javi@gmail.com", style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _quickAction(
                        icon: Icons.music_note,
                        label: "Spotify",
                        onPressed: () {
                          print("Spotify button pressed");
                        },
                      ),
                      _quickAction(
                        icon: Icons.notifications,
                        label: AppLocalizations.of(context)!.settingsNotifications,
                        onPressed: () {
                          print("Notifications button pressed");
                        },
                      ),
                      _quickAction(
                        icon: Icons.help_outline,
                        label: AppLocalizations.of(context)!.settingsContact,
                        onPressed: () {
                          print("Contact button pressed");
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF1C1C1C),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.settingsTitle,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Icon(Icons.language, color: Colors.purple),
                            SizedBox(width: 16),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _selectedLanguage,
                                dropdownColor: Color(0xFF1C1C1C),
                                style: TextStyle(color: Colors.white),
                                iconEnabledColor: Colors.white70,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.settingsLanguage,
                                  labelStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white24),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.purple),
                                  ),
                                ),
                                items: [
                                  DropdownMenuItem(
                                    value: 'eng',
                                    child: Text(AppLocalizations.of(context)!.settingsLanguageEng),
                                  ),
                                  DropdownMenuItem(
                                    value: 'esp',
                                    child: Text(AppLocalizations.of(context)!.settingsLanguageEsp),
                                  ),
                                  DropdownMenuItem(
                                    value: 'cat',
                                    child: Text(AppLocalizations.of(context)!.settingsLanguageCat),
                                  ),
                                ],
                                onChanged: (val) {
                                  setState(() {
                                    _selectedLanguage = val!;
                                    // Get.updateLocale(Locale(_selectedLanguage));
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      _settingSwitch(
                        Icons.dark_mode,
                        AppLocalizations.of(context)!.settingsDarkMode,
                        _darkMode,
                            (val) {
                          setState(() {
                            _darkMode = val;
                          });
                        },
                      ),
                      _settingItem(
                        Icons.person,
                        AppLocalizations.of(context)!.settingsProfileSettings,
                        trailingText: AppLocalizations.of(context)!.settingsProfileSettingsMini,
                        onTap: () => Get.offAllNamed(Routes.PROFILEEDITOR),
                      ),
                      _settingItem(Icons.qr_code, AppLocalizations.of(context)!.settingsMyQRCode, onTap: () {}),
                      _settingItem(Icons.lock, AppLocalizations.of(context)!.settingsChangePassword, onTap: () {}),
                      Divider(color: Colors.white24, height: 32),
                      _settingItem(
                        Icons.logout,
                        AppLocalizations.of(context)!.settingsLogout,
                        trailingText: AppLocalizations.of(context)!.settingsLogoutMini,
                        onTap: () {
                          authC.logout();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _quickAction({required IconData icon, required String label, required VoidCallback onPressed}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: IconButton(
            icon: Icon(icon, color: Colors.black),
            onPressed: onPressed,
            tooltip: label,
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _settingItem(IconData icon, String title, {String? trailingText, VoidCallback? onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.purple),
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: trailingText != null
          ? Text(trailingText, style: TextStyle(color: Colors.white70))
          : Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
      onTap: onTap,
    );
  }

  Widget _settingSwitch(IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.purple),
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.purple,
      ),
    );
  }
}
