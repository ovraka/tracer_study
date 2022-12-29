import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/theme/colors.dart';

class RegisterController extends GetxController {
  TextEditingController nimC = TextEditingController();
  TextEditingController nikC = TextEditingController();
  TextEditingController phoneNumberC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  TextEditingController genderC = TextEditingController();
  TextEditingController graduateYearC = TextEditingController();

  TextEditingController passwordValidOperatorC = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isLoadingDialog = false.obs;
  var isPasswordHide = true.obs;

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
    if (passwordValidOperatorC.text.isNotEmpty) {
      try {
        String email = auth.currentUser!.email!;

        final operatorCredential = await auth.signInWithEmailAndPassword(
            email: email, password: passwordValidOperatorC.text);

        final credential = await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: 'usm2023',
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

          await credential.user!.sendEmailVerification();

          await auth.signOut();

          final operatorCredential = await auth.signInWithEmailAndPassword(
              email: email, password: passwordValidOperatorC.text);

          Get.back();
          Get.back();
          Get.snackbar("Berhasil!", "Berhasil menambahkan user");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar("Terjadi kesalahan", "Password minimal 6 karakter");
        } else if (e.code == 'emailalready-in-use') {
          Get.snackbar("Terjadi kesalahan", "Email telah digunakan");
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
              "Terjadi kesalahan", "Password salah, masukkan dengan benar");
        } else {
          isLoadingDialog.value = false;
          Get.snackbar("Terjadi kesalahan", "${e.code}");
        }
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan",
            "Anda tidak dapat menambahkan user, silahkan hubungi administrator");
      } finally {
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
      Get.snackbar("Terjadi kesalahan", "Password tidak boleh kosong");
    }
  }

  Future<void> validasiOperator() async {
    if (firstNameC.text.isNotEmpty &&
        lastNameC.text.isNotEmpty &&
        nimC.text.isNotEmpty &&
        nikC.text.isNotEmpty &&
        phoneNumberC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        graduateYearC.text.isNotEmpty) {
      isLoading.value = true;
      Get.defaultDialog(
        backgroundColor: Colors.grey[200],
        title: "Konfirmasi Operator",
        content: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Masukkan password anda",
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
                height: 20,
              ),
              Obx(() => Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: softWhite,
                    ),
                    child: TextField(
                      controller: passwordValidOperatorC,
                      obscureText: isPasswordHide.value,
                      cursorColor: softNavy,
                      autocorrect: false,
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: softNavy)),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            splashRadius: 1,
                            onPressed: () {
                              isPasswordHide.toggle();
                            },
                            icon: Icon(
                              isPasswordHide.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: softGrey,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: softGrey))),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        isLoading.value = false;
                        Get.back();
                      },
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
                        if (isLoadingDialog.isFalse) {
                          await addNewUser();
                        }
                        isLoading.value = false;
                      },
                      child: Text(
                        isLoadingDialog.isFalse ? 'Konfirmasi' : 'Loading...',
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
    } else {
      Get.snackbar("Terjadi kesalahan", "Semua data harus di isi");
    }
  }
}
