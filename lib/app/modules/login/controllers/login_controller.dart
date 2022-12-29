import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/theme/colors.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  RxBool isLoading = false.obs;
  var isPasswordHide = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        final credential = await auth.signInWithEmailAndPassword(
            email: emailC.text, password: passwordC.text);

        if (credential.user != null) {
          if (credential.user!.emailVerified == true) {
            if (passwordC.text == "usm2023") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
              backgroundColor: softWhite,
              title: "Perhatian!",
              content: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Email yang anda gunakan belum terverifikasi, silahkan verifikasi email anda',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          fontSize: 14,
                          color: softNavy,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () => Get.back(),
                            child: Text(
                              "Batal",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                fontSize: 14,
                                color: softNavy,
                                fontWeight: FontWeight.w300,
                              )),
                            )),
                        Obx(() => TextButton(
                            onPressed: () async {
                              try {
                                await credential.user!.sendEmailVerification();
                                Get.back();
                                Get.snackbar('Berhasil',
                                    'Kami telah mengirim email verifikasi ke akun anda, silahkan cek email anda');
                                isLoading.value = false;
                              } catch (e) {
                                isLoading.value = false;
                                Get.snackbar('Terjadi kesalahan',
                                    'Tidak dapat mengirim email verifikasi, silahkan hubungi operator');
                              }
                            },
                            child: Text(
                              isLoading.isFalse
                                  ? 'Kirim ulang email'
                                  : 'Loading...',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                fontSize: 14,
                                color: softNavy,
                                fontWeight: FontWeight.w600,
                              )),
                            ))),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar('Terjadi kesalahan', 'Email belum terdaftar');
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
              'Terjadi kesalahan', 'Password salah, silahkan coba lagi');
        }
      } catch (e) {
        Get.snackbar('Terjadi kesalahan', 'Anda tidak dapat login');
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar(
          'Terjadi kesalahan', 'Email dan Password tidak boleh kosong');
    }
  }
}
