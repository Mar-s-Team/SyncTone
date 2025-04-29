import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctone/routes/app_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../controllers/auth_controller.dart';
import 'profile_editor_controller.dart';

class EditProfileScreen extends GetView<ProfileEditorController> {
  const EditProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
    final t = AppLocalizations.of(context)!;


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.toNamed(Routes.SETTINGS),
          /*onPressed: (){final authC = Get.find<AuthController>();
          authC.loadUser();
        Get.offNamed((Routes.SETTINGS));*/


        ),
        title: Text(t.profileEditorTitle, style: const TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(t.profileEditorInfo, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              _buildTextField(controller.nameController, t.profileEditorName),
              const SizedBox(height: 12),
              _buildTextField(controller.lastNameController, t.profileEditorLastName),
              const SizedBox(height: 12),
              _buildTextField(controller.usernameController, t.profileEditorUsername),
              const SizedBox(height: 20),
              Text(t.profileEditorFavGenres, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              Obx(() => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.genres.map((genre) {
                  final isSelected = controller.selectedGenres.contains(genre);
                  return ChoiceChip(
                    label: Text(genre),
                    selected: isSelected,
                    onSelected: (_) => controller.toggleGenre(genre),
                    selectedColor: Colors.purple,
                    backgroundColor: Colors.grey.shade800,
                    labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.white70),
                  );
                }).toList(),
              )),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: controller.saveProfile,
                  child: Text(t.profileEditorSave, style: const TextStyle(color: Colors.white, fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white12,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

}