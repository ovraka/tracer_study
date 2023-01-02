import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/theme/colors.dart';
import '../../../data/theme/custom_widget.dart';
import '../controllers/edit_password_controller.dart';

class EditPasswordView extends GetView<EditPasswordController> {
  const EditPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: softNavy,
        title: Text("EDIT PASSWORD",
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
          Text("Password Saat Ini",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: softNavy))),
          const SizedBox(
            height: 5,
          ),
          inputPassword(
              controller: controller.currentPasswordController,
              obscureText: controller.isCurrentPasswordHide,
              onPressed: () {
                controller.isCurrentPasswordHide.toggle();
              },
              isPasswordHide: controller.isCurrentPasswordHide,
              hintText: ""),
          const SizedBox(
            height: 20,
          ),
          Text("Password Baru",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: softNavy))),
          const SizedBox(
            height: 5,
          ),
          inputPassword(
              controller: controller.newPasswordController,
              obscureText: controller.isNewPassworddHide,
              onPressed: () {
                controller.isNewPassworddHide.toggle();
              },
              isPasswordHide: controller.isNewPassworddHide,
              hintText: ""),
          const SizedBox(
            height: 20,
          ),
          Text("Konfirmasi Password Baru",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: softNavy))),
          const SizedBox(
            height: 5,
          ),
          inputPassword(
              controller: controller.confirmNewPasswordController,
              obscureText: controller.isConfirmNewPasswordHide,
              onPressed: () {
                controller.isConfirmNewPasswordHide.toggle();
              },
              isPasswordHide: controller.isConfirmNewPasswordHide,
              hintText: ""),
          const SizedBox(
            height: 30,
          ),
          Obx(() => basicButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  controller.editPassword();
                }
              },
              buttonText: controller.isLoading.isFalse
                  ? 'UBAH PASSWORD'
                  : 'Loading...'))
        ],
      ),
    );
  }
}
