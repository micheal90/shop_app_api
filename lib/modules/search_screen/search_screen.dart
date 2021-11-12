import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/favorites_screen/favorite_controller.dart';
import 'package:shop_app/modules/home_screen/home_controller.dart';
import 'package:shop_app/modules/search_screen/search_controller.dart';
import 'package:shop_app/shared/constants.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  static const routeName = '/search_screen';
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _searchController = TextEditingController();
  final homeController = Get.find<HomeController>();
  final favController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: KBackgroungColor,
          elevation: 0,
          titleSpacing: 0,
          leading: IconButton(
              onPressed: () {
                Get.back();
                _searchController.dispose();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: Text(
            'Search',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GetBuilder<SearchController>(
                  init: Get.find<SearchController>(),
                  builder: (controller) => Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        controller: _searchController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Search',
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String val) => controller.search(val),
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return 'enter any text to search';
                          } else
                            return null;
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Obx(() => controller.isLoading.value
                          ? LinearProgressIndicator()
                          : Container()),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) => Container(
                                    color: KBackgroungColor,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Stack(
                                          alignment:
                                              AlignmentDirectional.bottomStart,
                                          children: [
                                            Image(
                                              height: 150,
                                              width: 150,
                                              fit: BoxFit.fill,
                                              image: NetworkImage(controller
                                                  .searchProducts[index].image),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller
                                                      .searchProducts[index]
                                                      .name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                                const SizedBox(height: 20   ,),
                                                Text(
                                                  '${controller.searchProducts[index].price.round()}',
                                                  style: TextStyle(
                                                      color: KPrimaryColor,
                                                      fontSize: 12.0),
                                                ),
                                               
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              separatorBuilder: (context, index) => Divider(),
                              itemCount: controller.searchProducts.length)),
                    ],
                  ),
                ))));
  }
}
