import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/auth/auth_controller.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class HomeController extends GetxController {
  AuthController authController = Get.put(AuthController());
  List<BannerModel> _banners = [];
  List<ProductModel> _products = [];
  List<BannerModel> get banners => [..._banners];
  List<ProductModel> get products => [..._products];
  Map favoriteList = {};
  RxBool isloading = false.obs;

  @override
  void onInit() {
    getHomeData();
    super.onInit();
  }

  Future getHomeData() async {
    isloading.value = true;

    await DioHelper.getData(url: HOME, token: authController.token)
        .then((value) {
      HomeModel homeModel = HomeModel.fromJson(value.data);
      _banners = homeModel.data.banners;
      _products = homeModel.data.products;
      homeModel.data.products.forEach((element) {
        favoriteList.addAll({element.id: element.inFavorite});
      });
      print(favoriteList.toString());
      update();
    }).catchError((e) {
      Get.snackbar('Occureed Error', e.toString());
    });
    isloading.value = false;
  }

  changeFavorite(int productId) {
    favoriteList[productId] = !favoriteList[productId];
    update();
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
