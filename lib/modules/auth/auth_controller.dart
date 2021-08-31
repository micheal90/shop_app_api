import 'package:get/get.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class AuthController extends GetxController {
  RxBool isPassword = true.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void login({
    required String email,
    required String password,
  }) async {
    await DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    })
        .then((value) => Get.snackbar(
            'Error Login Account', value.data['message'],
            snackPosition: SnackPosition.BOTTOM))
        .catchError((e) {
      print(e.toString());
      Get.snackbar('Occurred Error!',
          'There may be an error, plase check your internet connection.',
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  changeIsPassword() {
    isPassword.value = !isPassword.value;
  }
}
