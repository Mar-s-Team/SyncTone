import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:synctone/controllers/auth_controller.dart';
import 'package:synctone/models/user_model.dart';
import 'package:synctone/routes/app_pages.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final AuthController authC = Get.find<AuthController>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _cityController = TextEditingController();
  final _spotifyUsernameController = TextEditingController();


  final List<String> _genres = [
    "Pop", "Rock", "Rap", "Hip Hop", "House",
    "Spanish", "Lyrical", "Soul", "Techno"
  ];

  Set<String> _selectedGenres = {"Pop"};

  @override
  Widget build(BuildContext context) {
    UserModel? loggedUser = authC.loggedUser;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.toNamed(Routes.SETTINGS),
        ),
        title: Text(AppLocalizations.of(context)!.profileEditorTitle, style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Spotify box
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF2E2E2E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.music_note, size: 36, color: Colors.purple),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Link your Spotify account", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text("Get more accurate recommendations and statistics using your Spotify data", style: TextStyle(color: Colors.white70, fontSize: 12)),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: _spotifyUsernameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Your Spotify username here...",
                        hintStyle: TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.purple.shade100.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              Text(AppLocalizations.of(context)!.profileEditorInfo, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 12),
              _buildTextField(_nameController, AppLocalizations.of(context)!.profileEditorName),
              SizedBox(height: 12),
              _buildTextField(_cityController, AppLocalizations.of(context)!.profileEditorLastName),
              SizedBox(height: 12),
              _buildTextField(_usernameController, AppLocalizations.of(context)!.profileEditorUsername),

              SizedBox(height: 20),

              Text(AppLocalizations.of(context)!.profileEditorFavGenres, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 10),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _genres.map((genre) {
                  final isSelected = _selectedGenres.contains(genre);
                  return ChoiceChip(
                    label: Text(genre),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedGenres.add(genre);
                        } else {
                          _selectedGenres.remove(genre);
                        }
                      });
                    },
                    selectedColor: Colors.purple,
                    backgroundColor: Colors.grey.shade800,
                    labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.white70),
                  );
                }).toList(),
              ),

              SizedBox(height: 24),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Aquí puedes guardar la info
                    print("Name: ${_nameController.text}");
                    print("Username: ${_usernameController.text}");
                    print("City: ${_cityController.text}");
                    print("Spotify: ${_spotifyUsernameController.text}");
                    print("Genres: $_selectedGenres");
                  },
                  child: Text(AppLocalizations.of(context)!.profileEditorSave, style: TextStyle(color: Colors.white, fontSize: 16)),
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
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white54),
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
