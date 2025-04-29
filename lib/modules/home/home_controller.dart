import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synctone/api/api_endpoints.dart';
import 'package:synctone/api/api_service.dart';
import 'package:synctone/models/track.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  SupabaseClient client = Supabase.instance.client;
  RxList<Track> newReleases = List<Track>.empty().obs;
  RxList<Track> trendingSpanish = List<Track>.empty().obs;

  @override
  void onInit() async {
    isLoading.value = true;
    await getNewReleases();
    await getTrendingSpanish();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> getNewReleases() async {
    List<Track>? newReleasesData = await ApiService.getCustomTracks(ApiEndpoints.newReleases);
    newReleases(newReleasesData);
    newReleases.refresh();
  }

  Future<void> getTrendingSpanish() async {
    List<Track>? trendingSpanishData = await ApiService.getCustomTracks(ApiEndpoints.trendingSpanish);
    trendingSpanish(trendingSpanishData);
    trendingSpanish.refresh();
  }
}