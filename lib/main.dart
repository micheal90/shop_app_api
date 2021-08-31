import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/modules/auth/signup/signup_screen.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/binding.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'modules/auth/login/login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main() {
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      title: 'Shop App',
      theme: ThemeData(
          scaffoldBackgroundColor: KBackgroungColor,
          primarySwatch: Colors.deepOrange,
          primaryColor: KPrimaryColor,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: KPrimaryColor,
          )),
      routes: {
        '/': (_) => OnBoardingScreen(),
        LoginScreen.routName: (_) => LoginScreen(),
        SignUpScreen.routName: (_) => SignUpScreen(),
      },
    );
  }
}
