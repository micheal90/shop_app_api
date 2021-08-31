import 'package:get/get.dart';
import 'package:shop_app/modules/login/auth_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
