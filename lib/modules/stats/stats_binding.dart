import 'package:get/get.dart';
import 'package:synctone/modules/stats/stats_controller.dart';

class StatsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatsController>(
          () => StatsController(),
    );
  }
}