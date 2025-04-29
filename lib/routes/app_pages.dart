
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:synctone/modules/friends/friends_binding.dart';
import 'package:synctone/modules/home/home_binding.dart';
import 'package:synctone/modules/home/home_screen.dart';
import 'package:synctone/modules/location/location_binding.dart';
import 'package:synctone/modules/location/location_screen.dart';
import 'package:synctone/modules/login/login_binding.dart';
import 'package:synctone/modules/login/login_screen.dart';
import 'package:synctone/modules/main/main_binding.dart';
import 'package:synctone/modules/main/main_view.dart';
import 'package:synctone/modules/player/player_binding.dart';
import 'package:synctone/modules/player/player_screen.dart';
import 'package:synctone/modules/favourites/favourites_binding.dart';
import 'package:synctone/modules/favourites/favourites_screen.dart';
import 'package:synctone/modules/settings/settings_binding.dart';
import 'package:synctone/modules/settings/settings_screen.dart';
import '../modules/friends/friends_screen.dart';
import '../modules/profile_editor/profile_editor_binding.dart';
import '../modules/profile_editor/profile_editor_screen.dart';
import '../modules/register/register_binding.dart';
import '../modules/register/register_screen.dart';
import 'package:synctone/modules/change_password/change_password_binding.dart';
import 'package:synctone/modules/change_password/change_password_screen.dart';
import 'package:synctone/modules/splash/splash_screen.dart';
import 'package:synctone/modules/qr_scanner/qr_scanner_screen.dart';
import 'package:synctone/modules/qr_scanner/qr_scanner_binding.dart';
part 'app_routes.dart';


class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
      title: 'SyncTone',
    ),
    GetPage(
      name: _Paths.FRIENDS,
      page: () => const FriendsScreen(),
      binding: FriendsBinding(),
      title: 'MySyncFriends',
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => MainScreen(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () =>  const SettingsScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.FAVOURITES,
      page: () => const FavouritesScreen(),
      binding: FavouritesBinding(),
    ),
    GetPage(
      name: _Paths.PLAYER,
      page: () => PlayerScreen(),
      binding: PlayerBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION,
      page: () => LocationScreen(),
      binding: LocationBinding(),
    ),
    GetPage(
      name: _Paths.CHANGEPASSWORD,
      page: () => const ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashScreen(), // 👈 nueva ruta splash
    ),
    /*
    GetPage(
      name: _Paths.QRSCANNER,
      page: () => const QRScannerScreen(),
      binding: QRScannerBinding(),
    ),
     */
    GetPage(
      name: _Paths.PROFILEEDITOR,
      page: () => EditProfileScreen(),
      binding: ProfileEditorBinding(),
    )
  ];
}