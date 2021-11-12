import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/modules/auth/auth_controller.dart';
import 'package:shop_app/modules/settings_screen/edit_user_data_screen.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/widgets/default_button.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: authController.getUserData(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetBuilder<AuthController>(
                  init: Get.find<AuthController>(),
                  builder: (controller) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          color: KPrimaryColor,
                        ),
                        title: Text("Name"),
                        subtitle: Text(controller.userData.name),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.email,
                          color: KPrimaryColor,
                        ),
                        title: Text("E-Mail"),
                        subtitle: Text(controller.userData.email),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: KPrimaryColor,
                        ),
                        title: Text("Phone"),
                        subtitle: Text(controller.userData.phone),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          DefaultButton(
                            
                              text: 'UPDATE',
                              onPressed: () =>
                                  Get.toNamed(EditUserDataScreen.routeName)),
                          DefaultButton(
                            text: 'LOGOUT',
                            onPressed: () => controller.logOut(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
