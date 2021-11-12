import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shop_app/models/catrgories_model.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class CategoriesConntroller extends GetxController {
  List<DataModel> _categories = [];
  List<DataModel> get categories => [..._categories];
  ValueNotifier<bool> isloading = ValueNotifier(false);

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  getCategories() async {
    isloading.value = true;
    
    await DioHelper.getData(url: CATEGORIES).then((value) {
      categories.clear();
      //print(value.data);
      CategoriesModel categoriesModel = CategoriesModel.fronJson(value.data);
      _categories = categoriesModel.data.data;
    }).catchError((e) {
      Get.snackbar('Occureed Error', e.toString());
    });
    isloading.value = false;
    update();
  }
}
