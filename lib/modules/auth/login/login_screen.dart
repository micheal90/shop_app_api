import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/modules/auth/signup/signup_screen.dart';
import 'package:shop_app/modules/login/auth_controller.dart';
import 'package:shop_app/shared/constants.dart';

class LoginScreen extends GetWidget<AuthController> {
  static const routName = '/login_screen';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  void _submit(context) {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    controller.login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
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
                    'Login',
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
                  Obx(
                    () => TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: controller.isPassword.value,
                      onFieldSubmitted: _submit,
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
                    height: 20.0,
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.blue,
                    child: MaterialButton(
                      onPressed: () => _submit(context),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.white,
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
                        'Don\'t have an account?',
                      ),
                      TextButton(
                        onPressed: () => Get.toNamed(SignUpScreen.routName),
                        child: Text(
                          'Register Now',
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
