import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController nimC = TextEditingController();
  TextEditingController nikC = TextEditingController();
  TextEditingController phoneNumberC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  TextEditingController genderC = TextEditingController();
  TextEditingController graduateYearC = TextEditingController();

  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(
      value: 'Laki-laki',
      child: Text('Laki-laki'),
    ),
    const DropdownMenuItem(
      value: 'Perempuan',
      child: Text('Perempuan'),
    ),
  ].obs;

  var selectedGender = 'Laki-laki'.obs;

  Future<void> addNewUser() async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: emailC.text,
        password: 'uhamka123',
      );

      if (credential.user != null) {
        isLoading.value = true;
        String uid = credential.user!.uid;
        await fireStore.collection('user').doc(uid).set({
          "uid": uid,
          "nim": nimC.text,
          "nik": nikC.text,
          "first_name": firstNameC.text,
          "last_name": lastNameC.text,
          "phone_number": phoneNumberC.text,
          "email": emailC.text,
          "gender": selectedGender.value,
          "graduate_year": graduateYearC.text,
          "role": "alumni",
          "create_at": DateTime.now(),
        });

        Get.snackbar("Berhasil!", "Berhasil menambahkan user");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Terjadi Kesalahan", "Password minimal 6 kqarakter");
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Terjadi Kesalahan", "Email yang sudah di gunakan");
      } else if (e.code == 'wrong_password') {
        Get.snackbar("Terjadi Kesalahan", "Password yang anda masukkan salah");
      }
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan",
          "Anda tidak dapat menambahkan user, silahkan hubungi administrator");
    } finally {
      isLoading.value = false;
    }
  }
}
