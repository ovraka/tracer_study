import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController passwordC = TextEditingController();

  var isPasswordHide = true.obs;
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  void newPassword() async {
    if (passwordC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        if (passwordC.text != "usm2023") {
          await auth.currentUser!.updatePassword(passwordC.text);

          String email = auth.currentUser!.email!;

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
              email: email, password: passwordC.text);

          Get.offAllNamed(Routes.HOME);
        } else {
          Get.snackbar('Terjadi kesalahan',
              'Password baru harus di ubah, jangan menggunakan password default kembali');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar("Terjadi kesalahan", "Password minimal 6 karakter");
        }
      } catch (e) {
        Get.snackbar('Terjadi kesalahan',
            'Anda tidak dapat mengganti password, silahkan hubungi operator');
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar('Terjadi kesalahan', 'Password baru tidak boleh kosong');
    }
  }
}
