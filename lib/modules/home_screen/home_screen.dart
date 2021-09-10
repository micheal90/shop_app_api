import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/modules/categories_screen/categories_controller.dart';
import 'package:shop_app/modules/favorites_screen/favorite_controller.dart';
import 'package:shop_app/modules/home_screen/home_controller.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/widgets/category_list_item.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<HomeController>(
        init: Get.find<HomeController>(),
        builder: (controller) => controller.isloading.value &&
                Get.find<CategoriesConntroller>().isloading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      items: controller.banners
                          .map((e) => ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image(
                                  image: NetworkImage(e.image),
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                ),
                              ))
                          .toList(),
                      options: CarouselOptions(
                        height: 180,
                        aspectRatio: 1,
                        viewportFraction: 0.85,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Categories',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          buildCategoriesList(),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'New Products',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildGridProducts()
                  ],
                ),
              ),
      ),
    );
  }

  Widget buildCategoriesList() {
    return GetBuilder<CategoriesConntroller>(
      init: Get.find<CategoriesConntroller>(),
      builder: (controller) => Container(
          height: 100,
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => CategoryListItem(
              image: controller.categories[index].image,
              text: controller.categories[index].name,
            ),
            separatorBuilder: (context, index) => const SizedBox(
              width: 5,
            ),
            itemCount: 5,
          )),
    );
  }

  Container buildGridProducts() {
    return Container(
      color: Colors.grey[200],
      child: GetBuilder<HomeController>(
        init: Get.find<HomeController>(),
        builder: (controller) => GridView.builder(
            itemCount: controller.products.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              maxCrossAxisExtent: 250,
              childAspectRatio: 1 / 1.6,
            ),
            itemBuilder: (context, index) => Container(
                  color: KBackgroungColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Image(
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.fill,
                            image:
                                NetworkImage(controller.products[index].image),
                          ),
                          if (controller.products[index].discount != 0)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
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
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.products[index].name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${controller.products[index].price.round()}',
                                  style: TextStyle(
                                      color: KPrimaryColor, fontSize: 12.0),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                if (controller.products[index].discount != 0)
                                  Text(
                                    '${controller.products[index].oldPrice.round()}',
                                    style: TextStyle(
                                        color: KPrimaryColor,
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 12.0),
                                  ),
                                Spacer(),
                                IconButton(
                                  onPressed: () =>
                                      Get.find<FavoriteController>()
                                          .changeFavorite(
                                              controller.products[index].id),
                                  icon: controller.favoriteHomeList[controller.products[index].id]
                                      ? Icon(Icons.favorite,color: Colors.red,)
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
                    ],
                  ),
                )),
      ),
    );
  }
}
