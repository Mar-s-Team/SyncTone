
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:synctone/modules/home/home_binding.dart';
import 'package:synctone/modules/home/home_view.dart';
import 'package:synctone/modules/login/login_binding.dart';
import 'package:synctone/modules/login/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
  ];
}