import 'package:get/get.dart';
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/auth/auth_controller.dart';
import 'package:shop_app/modules/home_screen/home_controller.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class FavoriteController extends GetxController {
  RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;
  List<FavoriteProductModel> _favoriteProductList = [];
  List<FavoriteProductModel> get favoriteProductList =>
      [..._favoriteProductList];

  @override
  void onInit() {
    getFavorites();
    super.onInit();
  }

  getFavorites() async {
    _isLoading.value = true;
    favoriteProductList.clear();
    DioHelper.getData(url: FAVORITE, token: Get.find<AuthController>().token)
        .then((value) {
      print(value.data);
      FavoriteModel favoriteModel = FavoriteModel.fromJson(value.data);
      print(favoriteModel.data.favData[1].productModel.id);
      favoriteModel.data.favData.forEach((element) {
        favoriteProductList.add(element.productModel);
      });
      update();
      print(favoriteProductList);
    }).catchError((e) {
      print(e.toString());
      Get.snackbar('An error occurred!', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    });
    _isLoading.value = false;
  }

  changeFavorite(int productId) async {
    Get.find<HomeController>().changeFavorite(productId);

    DioHelper.postData(
      url: FAVORITE,
      data: {"product_id": productId},
      token: Get.find<AuthController>().token,
    ).then((value) {
      print(value.data);
      ChangeFavoriteModel favoriteModel =
          ChangeFavoriteModel.fromJson(value.data);
      if (!favoriteModel.status) {
        Get.find<HomeController>().changeFavorite(productId);
        Get.snackbar('An error occurred!', favoriteModel.message.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
    }).catchError((e) {
      Get.find<HomeController>().changeFavorite(productId);
      Get.snackbar('An error occurred!', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    });
  }
}
