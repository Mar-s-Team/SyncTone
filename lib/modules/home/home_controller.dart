import 'package:get/get.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

class HomeController extends GetxController {
  NotchBottomBarController bottomBarController = NotchBottomBarController();
  var index = 0.obs;
  void setIndex(i) => index.value = i;

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