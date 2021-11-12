import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/modules/auth/auth_controller.dart';
import 'package:shop_app/modules/auth/login/login_screen.dart';
import 'package:shop_app/modules/categories_screen/caterories_screen.dart';
import 'package:shop_app/modules/favorites_screen/favorites_screen.dart';
import 'package:shop_app/modules/home_screen/home_screen.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';
import 'package:shop_app/modules/settings_screen/settings_screen.dart';
import 'package:shop_app/shared/constants.dart';

class ControllView extends StatelessWidget {
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: Get.find<AuthController>(),
      builder: (controller) =>
          controller.isAuth == false ? LoginScreen() : TabScreen(),
    );
  }
}

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);
  static const routeName = '/tab_screen';
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _currentIndex = 0;
  void _changIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  late List<Map<String, dynamic>> _pages;
  @override
  void initState() {
    _pages = [
      {
        'title': 'Home',
        'body': HomeScreen(),
      },
      {
        'title': 'Categoriers',
        'body': CategoriesScreen(),
      },
      {
        'title': 'Favorites',
        'body': FavoritesScreen(),
      },
      {
        'title': 'Settings',
        'body': SettingsScreen(),
      },
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KBackgroungColor,
        elevation: 0,
        title: Text(
          _pages[_currentIndex]['title'],
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
              onPressed: ()=>Get.toNamed(SearchScreen.routeName),
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ))
        ],
      ),
      body: _pages[_currentIndex]['body'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: KBackgroungColor,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _changIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
