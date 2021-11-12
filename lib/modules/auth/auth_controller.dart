import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class AuthController extends GetxController {
  bool _isPassword = true;
  bool get isPassword => _isPassword;

  RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  String? _token;
  String? get token => _token;

  bool get isAuth => _token != null ? true : false;

  late UserData userData;
  late LoginModel loginModel;

  @override
  void onInit() async {
    super.onInit();
    _token = CacheHelper.getData(key: 'token');
  }

  Future login({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    //print(password);
    await DioHelper.postData(url: 'login', lang: 'en', data: {
      'email': email,
      'password': password,
    }).then((value) {
      // print(value.statusCode);
      loginModel = LoginModel.fromMap(value.data);
      // print(loginModel.data);
      if (loginModel.status) {
        //print(loginModel.data!.token);
        CacheHelper.putData(key: 'token', value: loginModel.data!.token)
            .then((value) {
          _token = loginModel.data!.token;
          
          //Get.offAndToNamed(TabScreen.routeName);
          update();
        });
      } else {
        Get.snackbar('Error Login Account', loginModel.message.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
    }).catchError((e) {
      print(e.toString());
      Get.snackbar('Error Login Account','An error occurred, try again please!',
          snackPosition: SnackPosition.BOTTOM);
    });
    isLoading.value = false;
  }

  Future signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    _isLoading.value = true;
    await DioHelper.postData(
      url: SIGNUP,
      data: {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
      },
    ).then((value) {
      loginModel = LoginModel.fromMap(value.data);
      // print(loginModel.data);
      if (loginModel.status) {
        //print(loginModel.data!.token);
        CacheHelper.putData(key: 'token', value: loginModel.data!.token)
            .then((value) {
          _token = loginModel.data!.token;

          //Get.offAndToNamed(TabScreen.routeName);
          update();
        });
      } else {
        Get.snackbar('Error Login Account', loginModel.message.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
    }).catchError((e) {
      print(e.toString());
      Get.snackbar('Error Login Account', 'An error occurred, try again please!',
          snackPosition: SnackPosition.BOTTOM);
    });
    _isLoading.value = false;
  }

  Future getUserData() async {
    //isLoading.value = true;
    await DioHelper.getData(url: GET_PROFILE, token: _token).then((value) {
      var userModel = LoginModel.fromMap(value.data);
      if (userModel.status) {
        userData = userModel.data!;
      }
    }).catchError((e) {
      print(e.toString());
      Get.snackbar(
        'An error occurred!',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    });
    //isLoading.value = false;
  }

  Future updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    isLoading.value = true;
    await DioHelper.putData(
      url: UPDATE_PROFILE,
      token: _token,
      data: {
        "name": name,
        "email": email,
        "phone": phone,
      },
    ).then((value) {
      LoginModel loginModel = LoginModel.fromMap(value.data);
      if (loginModel.status) {
        userData = loginModel.data!;
        Fluttertoast.showToast(
            msg: loginModel.message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: KPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        update();
      } else {
        Fluttertoast.showToast(
            msg: loginModel.message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }).catchError((e) {
      print(e.toString());
      Get.snackbar(
        'An error occurred!',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    });
    isLoading.value = false;
  }

  Future logOut() async {
    await CacheHelper.clearKey(key: 'token').then((value) {
      if (value) {
        _token = null;
      }
    });
    update();
  }

  changeIsPassword() {
    _isPassword = !_isPassword;
    update();
  }
}
