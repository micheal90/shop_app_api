import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/modules/home_screen/home_controller.dart';
import 'package:shop_app/shared/constants.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        init: Get.put(HomeController()),
        builder: (controller) => controller.isloading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    CarouselSlider(
                      items: controller.banners
                          .map((e) => Image(
                                image: NetworkImage(e.image),
                                fit: BoxFit.fill,
                                width: double.infinity,
                              ))
                          .toList(),
                      options: CarouselOptions(
                        height: 180,
                        aspectRatio: 1,
                        viewportFraction: 1.0,
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
                    buildGridProducts()
                  ],
                ),
              ),
      ),
    );
  }

  Container buildGridProducts() {
    return Container(
      color: Colors.grey[200],
      child: GetBuilder<HomeController>(
        init: Get.find(),
        builder: (controller) => GridView.builder(
            itemCount: controller.products.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              maxCrossAxisExtent: 250,
              childAspectRatio: 1 / 1.9,
            ),
            itemBuilder: (context, index) => Container(
                  color: Colors.white,
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
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                    size: 15,
                                  ),
                                  padding: EdgeInsets.zero,
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
