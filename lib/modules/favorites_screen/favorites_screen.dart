import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/modules/favorites_screen/favorite_controller.dart';
import 'package:shop_app/modules/home_screen/home_controller.dart';
import 'package:shop_app/shared/constants.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetX<FavoriteController>(
      init: Get.put(FavoriteController()),
      builder: (controllerObs) => controllerObs.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : GetBuilder<FavoriteController>(
              builder: (controller) => controller.favoriteProductList.isEmpty
                  ? Center(
                      child: Text(
                        'No favorite product found, yet',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) => Container(
                            color: KBackgroungColor,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.bottomStart,
                                  children: [
                                    Image(
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.fill,
                                      image: NetworkImage(controller
                                          .favoriteProductList[index].image),
                                    ),
                                    if (controller.favoriteProductList[index]
                                            .discount !=
                                        0)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        color: Colors.red,
                                        child: Text(
                                          'Discount',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
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
                                              .favoriteProductList[index].name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${controller.favoriteProductList[index].price.round()}',
                                              style: TextStyle(
                                                  color: KPrimaryColor,
                                                  fontSize: 12.0),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            if (controller
                                                    .favoriteProductList[index]
                                                    .discount !=
                                                0)
                                              Text(
                                                '${controller.favoriteProductList[index].oldPrice.round()}',
                                                style: TextStyle(
                                                    color: KPrimaryColor,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: 12.0),
                                              ),
                                            Spacer(),
                                            IconButton(
                                              onPressed: () => controller
                                                  .changeFavorite(controller
                                                      .favoriteProductList[
                                                          index]
                                                      .id),
                                              icon: homeController
                                                          .favoriteHomeList[
                                                      controller
                                                          .favoriteProductList[
                                                              index]
                                                          .id]
                                                  ? Icon(
                                                      Icons.favorite,
                                                      color: Colors.red,
                                                      size: 25,
                                                    )
                                                  : Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.grey,
                                                      size: 25,
                                                    ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: controller.favoriteProductList.length),
            ),
    ));
  }
}
