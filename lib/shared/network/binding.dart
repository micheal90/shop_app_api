import 'package:get/get.dart';
import 'package:shop_app/modules/auth/auth_controller.dart';
import 'package:shop_app/modules/categories_screen/categories_controller.dart';
import 'package:shop_app/modules/favorites_screen/favorite_controller.dart';
import 'package:shop_app/modules/home_screen/home_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => CategoriesConntroller());
    Get.lazyPut(() => FavoriteController());
  }
}
