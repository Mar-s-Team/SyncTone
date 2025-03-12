import 'package:get/get.dart';
import 'package:synctone/controllers/bottom_navigator_controller.dart';

class MainController extends GetxController {
  final BottomNavigatorController bottomNavController =  Get.put(BottomNavigatorController());

  void setIndex(i) {
    bottomNavController.index.value = i;
  }

  int getIndex(){
    return bottomNavController.index.value;
  }


  // RxList allPlayers = List<Player>.empty().obs;
  // Profile? profile;
  // SupabaseClient client = Supabase.instance.client;
  //
  // Future<Profile> getUserProfile() async{
  //   List<dynamic> res = await client
  //       .from("users")
  //       .select()
  //       .match({'id': client.auth.currentUser!.id});
  //   Profile profileData = Profile.fromJson(res.first);
  //   return profileData;
  //}
}