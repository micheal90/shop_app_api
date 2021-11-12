import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/modules/auth/auth_controller.dart';
import 'package:shop_app/modules/auth/signup/signup_screen.dart';
import 'package:shop_app/modules/controll_view/controll_view_screen.dart';
import 'package:shop_app/modules/home_screen/home_screen.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';
import 'package:shop_app/modules/settings_screen/edit_user_data_screen.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/binding.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'modules/auth/login/login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  var onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;

  runApp(MyApp(onBoarding));
}

class MyApp extends StatelessWidget {
  var onBoarding;
  MyApp(this.onBoarding);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Shop App',
      theme: ThemeData(
          scaffoldBackgroundColor: KBackgroungColor,
          primarySwatch: Colors.deepPurple,
          primaryColor: KPrimaryColor,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: KPrimaryColor,
          )),
      home: onBoarding ? ControllView() : OnBoardingScreen(),
      getPages: [
        //GetPage(name: TabScreen.routeName, page: () => TabScreen()),
        GetPage(name: LoginScreen.routeName, page: () => LoginScreen()),
        GetPage(name: SignUpScreen.routeName, page: () => SignUpScreen()),
        GetPage(name: HomeScreen.routeName, page: () => HomeScreen()),
        GetPage(
            name: EditUserDataScreen.routeName,
            page: () => EditUserDataScreen()),
        GetPage(name: SearchScreen.routeName, page: () => SearchScreen()),
      ],
    );
  }
}
