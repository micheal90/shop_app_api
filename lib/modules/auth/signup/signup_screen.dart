import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/shared/constants.dart';

import '../auth_controller.dart';

class SignUpScreen extends GetWidget<AuthController> {
  static const routeName = '/signup_screen';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  void _submit(context) {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    //Todo  call signup function
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KBackgroungColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SignUp',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (String value) {
                      print(value);
                    },
                    onChanged: (String value) {
                      print(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? val) {
                      if (!GetUtils.isEmail(val!)) {
                        return 'Incorrect email, provide email in avalid format';
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  GetBuilder<AuthController>(
                    builder:(controller) =>  TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: controller.isPassword,
                      onFieldSubmitted: (String value) {
                        print(value);
                      },
                      onChanged: (String value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        suffixIcon: InkWell(
                          onTap: () => controller.changeIsPassword(),
                          child: Icon(
                            Icons.remove_red_eye,
                          ),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? val) {
                        if (val!.length < 6) {
                          return 'The password is too short';
                        } else
                          return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  GetBuilder<AuthController>(
                    builder:(controller) => TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: controller.isPassword,
                      onFieldSubmitted: (String value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? val) {
                        if (val != _passwordController.text) {
                          return 'The password not match';
                        } else
                          return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Obx(
                    () => controller.isLoading.value
                        ? Center(child: CircularProgressIndicator())
                        : Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: () => _submit(context),
                              child: Text(
                                'SIGNUP',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                      ),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'LogIn',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
