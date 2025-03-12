import 'package:get/get.dart';
import 'package:synctone/routes/app_pages.dart';

class BottomNavigatorController extends GetxController {
  final pages = AppPages.routes;
  var index = 0.obs;

  void setIndex(i) => index.value = i;

  int findPageIndex (var page){
    return pages.indexOf(page);
  }

  String getPageTitle(int index){
    return pages[index].title.toString();
  }
}