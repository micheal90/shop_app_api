import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/controll_view/controll_view_screen.dart';
import 'package:shop_app/modules/home_screen/home_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class AuthController extends GetxController {
  bool _isPassword = true;
  bool get isPassword => _isPassword;

  RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  String? _token;
  String? get token => _token;
  RxBool get isAuth {
    if (_token != null)
      return true.obs;
    else
      return false.obs;
  }

  @override
  void onInit() {
    super.onInit();
    _token = CacheHelper.getData(key: 'token');
  }

  Future login({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    print(password);
    await DioHelper.postData(url: 'login', lang: 'en', data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.statusCode);
      var loginModel = LoginModel.fromMap(value.data);
      print(loginModel.data);
      if (loginModel.status) {
        //print(loginModel.data!.token);
        CacheHelper.putData(key: 'token', value: loginModel.data!.token)
            .then((value) {
          _token = loginModel.data!.token;
          // print(_token);
          // print(isAuth);
          Get.offAndToNamed(HomeScreen.routeName);
          update();
        });
      } else {
        Get.snackbar('Error Login Account', loginModel.message.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
    }).catchError((e) {
      print(e.toString());
      Get.snackbar('Error Login Account', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    });
    isLoading.value = false;
  }

  Future logOut() async {
    _token = null;
    await CacheHelper.clearKey(key: 'token').then((value) {
      if (value) {
        Get.offAll(ControllView());
      }
    });
  }

  changeIsPassword() {
    _isPassword = !_isPassword;
    print(_isPassword);
    update();
  }
}
