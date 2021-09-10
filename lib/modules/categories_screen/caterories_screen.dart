import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shop_app/modules/categories_screen/categories_controller.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesConntroller>(
      init: Get.find<CategoriesConntroller>(),
      builder: (controller) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => CategoryWidget(
          image: controller.categories[index].image,
          text: controller.categories[index].name,
        ),
        separatorBuilder: (context, index) => Divider(),
        itemCount: controller.categories.length,
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final String image;
  final String text;
  const CategoryWidget({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image(
        width: 100,
        fit: BoxFit.fill,
        image: NetworkImage(image),
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      trailing:
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
    );
  }
}
