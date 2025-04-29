import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctone/modules/favourites/favourites_controller.dart';

import 'package:synctone/widgets/settings_menu_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/favourites_list.dart';

class FavouritesScreen extends StatelessWidget {
  final FavouritesController controller = Get.put(FavouritesController());
  FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.favouritesTitle),
          leading: const SettingsMenuWidget(),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20
              ),
            child:Obx(
                (() => controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : SizedBox(
                    height:  610,
                    child:  controller.favourites.isEmpty
                    ? nothingInListText('songs', context)
                    :  FavouritesList(list: controller.favourites)
                ))
            ),
          ),
        ));
  }

  Widget nothingInListText(String mediaType, BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child:
      Text(
        AppLocalizations.of(context)!.favouritesNotYet,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}