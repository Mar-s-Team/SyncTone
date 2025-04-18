import 'package:flutter/material.dart';
import 'package:synctone/controllers/auth_controller.dart';
import 'settings_controller.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  final authC = Get.find<AuthController>();
  final SettingsController settingsController = Get.find<SettingsController>();

  @override
  void initState() {
    super.initState();
    settingsController.generateQR(); // Llama a la función para obtener el QR
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
            color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Profile', style: TextStyle(color: Colors.white, fontSize: 18)),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {},
          ),
          ListTile(
            title: Text('Language', style: TextStyle(color: Colors.white, fontSize: 18)),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {},
          ),
          SwitchListTile(
            title: Text('Dark Mode', style: TextStyle(color: Colors.white, fontSize: 18)),
            value: _darkMode,
            onChanged: (bool value) {
              setState(() {
                _darkMode = value;
              });
            },
            activeColor: Colors.white,
          ),
          ListTile(
            title: Text('My QR Code', style: TextStyle(color: Colors.white, fontSize: 18)),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() {
                            return settingsController.qrCodeWidget.value;
                          }),
                          const SizedBox(height: 20),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                            },
                              child: const Text(
                                'Close',
                                style: TextStyle(color: Colors.white),
                            )
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            title: Text('Contact us', style: TextStyle(color: Colors.white, fontSize: 18)),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Text('Log Out', style: TextStyle(color: Colors.black)),
        onPressed: () {authC.logout();},
      ),
    );
  }
}
