import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/theme/colors.dart';
import '../../../data/theme/custom_widget.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: IntrinsicHeight(
              child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                inputText(
                    readOnly: false,
                    controller: controller.emailC,
                    hintText: 'Email',
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 20,
                ),
                inputPassword(
                    controller: controller.passwordC,
                    obscureText: controller.isPasswordHide,
                    onPressed: () {
                      controller.isPasswordHide.toggle();
                    },
                    isPasswordHide: controller.isPasswordHide,
                    hintText: 'Password'),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => gradientButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        await controller.login();
                      }
                    },
                    buttonText: (controller.isLoading.isFalse
                        ? 'LOG IN'
                        : 'LOADING...'))),
                const SizedBox(
                  height: 20,
                ),
                linkText(
                    onPressed: () {
                      // Get.toNamed(Routes.FORGOT_PASSWORD);
                    },
                    color: seaBlue,
                    textButtonStyleFromSize: 16,
                    textStyleSize: 16,
                    text: 'Lupa password?')
              ],
            ),
          )),
        ),
      ),
    );
  }
}
