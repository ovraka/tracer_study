import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  RxBool isLoading = false.obs;
  var isPasswordHide = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        final credential = await auth.signInWithEmailAndPassword(
            email: emailC.text, password: passwordC.text);

        if (credential.user != null) {
          Get.offAllNamed(Routes.HOME);
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
    }
  }
}
