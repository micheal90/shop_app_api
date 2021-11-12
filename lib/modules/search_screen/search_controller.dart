import 'package:get/get.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/auth/auth_controller.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchController extends GetxController {
  RxBool _isLoading = RxBool(false);
  RxBool get isLoading => _isLoading;
  List<SearchProduct> searchProducts = [];

  search(String text) async {
    _isLoading.value = true;
    await DioHelper.postData(
      url: SEARCH,
      token: Get.find<AuthController>().token,
      data: {'text': text},
    ).then((value) {
      // print(value.data);
      var searchModel = SearchModel.fromJson(value.data);
      //print(searchModel.data.searchProducts);
      searchProducts = searchModel.data.searchProducts;
      update();
    }).catchError((e) {
      print(e.toString());
    });
    _isLoading.value = false;
  }
}
