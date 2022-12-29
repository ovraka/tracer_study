import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/theme/colors.dart';
import '../../../data/theme/custom_widget.dart';
import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: softNavy,
          title: Text("NEW PASSWORD",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: softWhite))),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text("New Password",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: softNavy))),
            const SizedBox(
              height: 5,
            ),
            inputPassword(
                controller: controller.passwordC,
                obscureText: controller.isPasswordHide,
                onPressed: () {
                  controller.isPasswordHide.toggle();
                },
                isPasswordHide: controller.isPasswordHide,
                hintText: "Password minimal 6 karakter"),
            const SizedBox(
              height: 30,
            ),
            Obx(() => basicButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.newPassword();
                  }
                },
                buttonText:
                    controller.isLoading.isFalse ? 'SIMPAN' : 'Loading...'))
          ],
        ));
  }
}
