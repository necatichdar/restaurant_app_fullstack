import 'package:get/get.dart';
import 'package:restaurant_rating/app/controller/auth_controller.dart';
import 'package:restaurant_rating/app/controller/detail_controller.dart';
import 'package:restaurant_rating/app/controller/home_controller.dart';
import 'package:restaurant_rating/app/controller/local_manager.dart';
import 'package:restaurant_rating/app/controller/map_controller.dart';

class MainBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(HomeController());
    Get.put(MapController());
    Get.put(DetailController());
    Get.lazyPut(() => LocaleManager());
  }
}
