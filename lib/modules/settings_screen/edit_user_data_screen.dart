import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/auth/auth_controller.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/widgets/default_button.dart';

class EditUserDataScreen extends GetWidget<AuthController> {
  EditUserDataScreen({Key? key}) : super(key: key);
  static const routeName = '/edit_userData_screen';
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  void _submit(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      controller
          .updateUserData(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
          )
          .then((value) => Get.back());
    }
  }

  @override
  Widget build(BuildContext context) {
    UserData userData = controller.userData;
    _nameController.text = userData.name;
    _emailController.text = userData.email;
    _phoneController.text = userData.phone;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: KBackgroungColor,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          'Edit User Data',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Obx(() => controller.isLoading.value
                    ? LinearProgressIndicator()
                    : Container()),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? val) {
                    if (val!.isEmpty) {
                      return 'Name must be not empty';
                    } else
                      return null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
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
                  height: 20.0,
                ),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    prefixIcon: Icon(
                      Icons.phone,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? val) {
                    if (val!.isEmpty) {
                      return 'Phone must be not empty';
                    } else
                      return null;
                  },
                ),
                SizedBox(
                  height: 40.0,
                ),
                GetX<AuthController>(
                    builder: (controllerObs) => controllerObs.isLoading.value
                        ? Center(child: CircularProgressIndicator())
                        : DefaultButton(
                          width: double.infinity,
                            text: 'UPDATE',
                            onPressed: () => _submit(context),
                          )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
