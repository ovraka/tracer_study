import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditQuestionController extends GetxController {
  TextEditingController questionC = TextEditingController();
  TextEditingController categoryC = TextEditingController();

  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateQuestion(String uid) async {
    if (questionC.text.isNotEmpty) {
      try {
        Map<String, dynamic> data = {
          "question": questionC.text,
        };
        isLoading.value = true;
        await firestore.collection('question').doc(uid).update(data);
        Get.back();
        Get.snackbar('Berhasil!', 'Anda berhasil update question');
      } catch (e) {
        Get.snackbar('Terjadi Kesalahan', 'Anda tidak dapat update question');
      } finally {
        isLoading.value = false;
      }
    }
  }
}
