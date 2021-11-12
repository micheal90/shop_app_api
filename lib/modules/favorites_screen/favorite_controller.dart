import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/modules/auth/auth_controller.dart';
import 'package:shop_app/modules/home_screen/home_controller.dart';
import 'package:shop_app/shared/constants.dart';
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

    await DioHelper.getData(
            url: GET_FAVORITES, token: Get.find<AuthController>().token)
        .then((value) {
      _favoriteProductList.clear();
      FavoriteModel favoriteModel = FavoriteModel.fromJson(value.data);
      favoriteModel.data.favData.forEach((element) {
        _favoriteProductList.add(element.productModel);
      });
      update();
      //print(_favoriteProductList);
    }).catchError((e) {
      print(e.toString());
      Get.snackbar('An error occurred!', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    });
    _isLoading.value = false;
  }

  changeFavorite(int productId) async {
    Get.find<HomeController>().changeFavoriteLocal(productId);

    DioHelper.postData(
      url: GET_FAVORITES,
      data: {"product_id": productId},
      token: Get.find<AuthController>().token,
    ).then((value) {
      //print(value.data);
      ChangeFavoriteModel favoriteModel =
          ChangeFavoriteModel.fromJson(value.data);
      if (!favoriteModel.status) {
        Get.find<HomeController>().changeFavoriteLocal(productId);
        Get.snackbar('An error occurred!', favoriteModel.message.toString(),
            snackPosition: SnackPosition.BOTTOM);
      } else {
        getFavorites();
        Fluttertoast.showToast(
            msg: favoriteModel.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: KPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }).catchError((e) {
      Get.find<HomeController>().changeFavoriteLocal(productId);
      Get.snackbar('An error occurred!', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    });
  }
}
