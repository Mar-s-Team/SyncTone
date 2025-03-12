
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:synctone/modules/friends/friends_binding.dart';
import 'package:synctone/modules/friends/friends_view.dart';
import 'package:synctone/modules/home/home_binding.dart';
import 'package:synctone/modules/home/home_view.dart';
import 'package:synctone/modules/login/login_binding.dart';
import 'package:synctone/modules/login/login_view.dart';
import 'package:synctone/modules/main/main_binding.dart';
import 'package:synctone/modules/main/main_controller.dart';
import 'package:synctone/modules/main/main_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      title: 'SyncTone',
    ),
    GetPage(
      name: _Paths.FRIENDS,
      page: () => const FriendsView(),
      binding: FriendsBinding(),
      title: 'MySyncFriends',
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
  ];
}