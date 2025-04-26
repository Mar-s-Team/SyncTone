import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctone/controllers/search_controller.dart';
import 'package:synctone/modules/home/home_controller.dart';
import 'package:synctone/widgets/home_page/search_box.dart';
import 'package:synctone/widgets/home_page/song_list_view.dart';
import 'package:synctone/widgets/settings_menu_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final MySearchController searchController = Get.put(MySearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homeTitle),
        leading: const SettingsMenuWidget(),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBox(
                onSubmit: () {
                  String search = Get.find<MySearchController>().searchTextController.text;
                  Get.find<MySearchController>().searchTextController.text = '';
                  Get.find<MySearchController>().search(search);
                  //Get.find<BottomNavigatorController>().goToSearchScreen();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.homeNewReleases,
                style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Obx(
                  (() => controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : SizedBox(
                      height:   200,
                      child: SongListView(songs: controller.newReleases)
                  ))
              )
            ],
          ),
        ),
      ),
    );
  }
}