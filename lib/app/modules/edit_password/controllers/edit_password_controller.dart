import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditPasswordController extends GetxController {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  RxBool isLoading = false.obs;
  var isCurrentPasswordHide = true.obs;
  var isNewPassworddHide = true.obs;
  var isConfirmNewPasswordHide = true.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  void editPassword() async {
    if (currentPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmNewPasswordController.text.isNotEmpty) {
      if (newPasswordController.text == confirmNewPasswordController.text) {
        isLoading.value = true;
        try {
          String emailUser = auth.currentUser!.email!;

          await auth.signInWithEmailAndPassword(
              email: emailUser, password: currentPasswordController.text);

          await auth.currentUser!.updatePassword(newPasswordController.text);

          Get.back();
          Get.snackbar('Berhasil!', 'Anda berhasil mengganti pasword');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong_password') {
            Get.snackbar('Terjadi Kesalahan',
                'Password sekarang anda salah, masukkan dengan benar');
          } else {
            Get.snackbar('Terjadi Kesalahan', e.code.toLowerCase());
          }
        } catch (e) {
          Get.snackbar('Terjadi Kesalahan',
              'Tidak dapat mengganti password, silahkan hubungi operator');
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar('Terjadi Kesalahan', 'Konfirmasi password harus sama');
      }
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Password tidak boleh kosong');
    }
  }
}
