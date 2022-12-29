import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/theme/colors.dart';
import '../../../data/theme/custom_widget.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: softNavy,
          title: Text("LUPA PASSWORD",
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
            Text("Email",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: softNavy))),
            const SizedBox(
              height: 5,
            ),
            inputText(
                readOnly: false,
                controller: controller.emailC,
                hintText: '',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name),
            const SizedBox(
              height: 20,
            ),
            Obx(() => basicButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.sendEmail();
                  }
                },
                buttonText: controller.isLoading.isFalse
                    ? 'Kirim untuk mereset password'
                    : 'Loading...')),
          ],
        ));
  }
}
