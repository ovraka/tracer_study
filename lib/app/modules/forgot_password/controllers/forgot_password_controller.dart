import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailC = TextEditingController();
  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  void sendEmail() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);
        Get.back();
        Get.snackbar('Berhasil!',
            'Email berhasil terkirim, kami telah mengirimkan email untuk me-reset password anda');
      } catch (e) {
        Get.snackbar('Terjadi Kesalahan',
            'Tidak dapat mengirim email, mohon coba lagi nanti');
      } finally {
        isLoading.value = false;
      }
    }
  }
}
