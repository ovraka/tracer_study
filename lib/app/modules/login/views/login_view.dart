import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/theme/colors.dart';
import '../../../data/theme/custom_widget.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: softNavy,
        title: Text("LOGIN",
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: softWhite))),
        centerTitle: true,
      ),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 150,
          height: 150,
          child: CircleAvatar(
            child: ClipOval(
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/tracer-study-8c1a7.appspot.com/o/usm.png?alt=media&token=ccd139b7-7f57-4648-925a-13e9267c1dde',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: RichText(
            text: TextSpan(
              text: 'ALUMNI ',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: softNavy)),
              children: const [
                TextSpan(
                    text: 'CONNECT.',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w100,
                        color: softNavy)),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
          child: Text("Universitas Saintek Muhammadiyah",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: softNavy))),
        ),
        const SizedBox(
          height: 50,
        ),
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
        Text("Password",
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
            hintText: ""),
        const SizedBox(
          height: 30,
        ),
        Obx(() => basicButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                await controller.login();
              }
            },
            buttonText: controller.isLoading.isFalse ? 'LOGIN' : 'Loading...')),
        const SizedBox(
          height: 20,
        ),
        linkText(
            onPressed: () {
              Get.toNamed(Routes.FORGOT_PASSWORD);
            },
            color: softNavy,
            textButtonStyleFromSize: 16,
            textStyleSize: 16,
            text: 'Lupa password?')
      ]),
    );
  }
}
