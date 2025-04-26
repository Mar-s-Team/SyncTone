import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:synctone/controllers/search_controller.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    required this.onSubmit,
    super.key,
  });
  final VoidCallback onSubmit;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: Get.find<MySearchController>().searchTextController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.14),
              child:
              const Icon(Icons.search, size: 22, color: Colors.white,)
          ),
          onPressed: () => onSubmit(),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(
          color: Color(
            0xFF67686D,
          ),
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        contentPadding: const EdgeInsets.only(
          left: 16,
          right: 0,
          top: 0,
          bottom: 0,
        ),
        filled: true,
        fillColor: const Color(0xFF3A3F47),
        hintText: AppLocalizations.of(context)!.homeSearchLabel,
      ),
      onSubmitted: (a) => onSubmit(),
    );
  }
}