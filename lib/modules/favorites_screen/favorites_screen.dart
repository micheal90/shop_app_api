import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/modules/favorites_screen/favorite_controller.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 
    return Center(
      child: IconButton(
          onPressed: () => Get.find<FavoriteController>().getFavorites(),
          icon: Icon(Icons.get_app)),
    );
  }
}
