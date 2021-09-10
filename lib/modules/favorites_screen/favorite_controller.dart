import 'package:get/get.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/modules/auth/auth_controller.dart';
import 'package:shop_app/modules/home_screen/home_controller.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class FavoriteController extends GetxController {
  changeFavorite(int productId) async {
    Get.find<HomeController>().changeFavorite(productId);

    DioHelper.postData(
      url: FAVORITE,
      data: {"product_id": productId},
      token: Get.find<AuthController>().token,
    ).then((value) {
      print(value.data);
      FavoriteModel favoriteModel = FavoriteModel.fromJson(value.data);
      if (!favoriteModel.status) {
        Get.find<HomeController>().changeFavorite(productId);
      }
    }).catchError((e) {
      Get.find<HomeController>().changeFavorite(productId);
    });
  }
}
