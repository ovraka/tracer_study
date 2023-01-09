import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid_type/uuid_type.dart';

class AddQuestionController extends GetxController {
  TextEditingController questionC = TextEditingController();
  TextEditingController subQuestionC = TextEditingController();

  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<DropdownMenuItem<String>> categoryItems = [
    const DropdownMenuItem(
      value: 'Masa TPB (Tahap Persiapan Bersama)',
      child: Text('Masa TPB'),
    ),
    const DropdownMenuItem(
      value: 'Internal Kampus',
      child: Text('Internal Kampus'),
    ),
    const DropdownMenuItem(
      value: 'Kompetensi',
      child: Text('Kompetensi'),
    ),
    const DropdownMenuItem(
      value: 'Pekerjaan',
      child: Text('Pekerjaan'),
    ),
    const DropdownMenuItem(
      value: 'Pekerjaan Utama',
      child: Text('Pekerjaan Utama'),
    ),
    const DropdownMenuItem(
      value: 'Pekerjaan Utama: Bekerja',
      child: Text('Pekerjaan Utama: Bekerja'),
    ),
    const DropdownMenuItem(
      value: 'Pekerjaan Utama: Wirausaha',
      child: Text('Pekerjaan Utama: Wirausaha'),
    ),
    const DropdownMenuItem(
      value: 'Pekerjaan Utama: Melanjutkan Studi',
      child: Text('Pekerjaan Utama: Melanjutkan Studi'),
    ),
    const DropdownMenuItem(
      value: 'Pekerjaan Utama: Tidak Bekrja',
      child: Text('Pekerjaan Utama: Tidak Bekerja'),
    ),
  ].obs;

  var defaultValueCategory = 'Masa TPB (Tahap Persiapan Bersama)'.obs;

  var qid = RandomUuidGenerator().generate().toString().split('-').last;

  Future<void> addNewQuestion() async {
    if (questionC.text.isNotEmpty) {
      try {
        var now = DateTime.now().toIso8601String();
        String adminId = auth.currentUser!.uid;
        isLoading.value = true;
        await firestore.collection('question').doc(qid).set({
          "qid": qid,
          "category": defaultValueCategory.value,
          "question": questionC.text,
          "create_by": adminId,
          "create_at": now,
        });

        Get.back();
        Get.snackbar("Berhasil!", "Berhasil menambahkan pertanyaan survey");
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan",
            "Anda tidak dapat menambahkan user, silahkan hubungi administrator");
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Terjadi kesalahan", "Password tidak boleh kosong");
    }
  }
}
