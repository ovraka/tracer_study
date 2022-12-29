import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracer_study/app/data/theme/colors.dart';
import 'package:tracer_study/app/data/theme/custom_widget.dart';

import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  Future<DocumentSnapshot<Map<String, dynamic>>> streamRole() async {
    String uid = auth.currentUser!.uid;
    return await firestore.collection('user').doc(uid).get();
  }

  void logOut() async {
    if (isLoading.isFalse) {
      print(auth.currentUser);
      Get.defaultDialog(
        backgroundColor: softWhite,
        title: "Perhatian!",
        content: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Apakah anda yakin ingin logout ?",
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
                        if (isLoading.isFalse) {
                          await auth.signOut();
                          Get.offAllNamed(Routes.LOGIN);
                        }
                        isLoading.value = false;
                      },
                      child: Text(
                        isLoading.isFalse ? 'Oke' : 'Loading...',
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
}
