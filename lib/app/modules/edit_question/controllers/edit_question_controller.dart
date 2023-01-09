import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid_type/uuid_type.dart';

class EditQuestionController extends GetxController {
  TextEditingController questionC = TextEditingController();
  TextEditingController categoryC = TextEditingController();
  TextEditingController addNewSubQuestionC = TextEditingController();
  TextEditingController editSubQuestionC = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isLoadingDialog = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateQuestion(String qid) async {
    if (questionC.text.isNotEmpty) {
      try {
        Map<String, dynamic> data = {
          "question": questionC.text,
        };
        isLoading.value = true;
        await firestore.collection('question').doc(qid).update(data);
        Get.back();
        Get.snackbar('Berhasil!', 'Anda berhasil update question');
      } catch (e) {
        Get.snackbar('Terjadi Kesalahan', 'Anda tidak dapat update question');
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> addNewSubQuestion(String sqid, String category) async {
    String operatorId = await auth.currentUser!.uid;
    var uuid = RandomUuidGenerator().generate().toString().split('-').first;
    String combineSqid = '$sqid-$uuid';
    CollectionReference<Map<String, dynamic>> colSubQuestion = await firestore
        .collection('question')
        .doc(sqid)
        .collection('sub_question');

    var now = DateTime.now().toIso8601String();

    if (addNewSubQuestionC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        await colSubQuestion.doc(combineSqid).set({
          "sqid": combineSqid,
          "category": category,
          "question": addNewSubQuestionC.text,
          "create_by": operatorId,
          "create_at": now,
        });

        Get.back();
        addNewSubQuestionC.clear();
        Get.snackbar(
            "Berhasil!", "Anda berhasil menambahkan sub pertanyaan survey");
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan",
            "Anda tidak dapat menambahkan sub question, silahkan hubungi administrator");
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Terjadi kesalahan", "Sub question tidak boleh kosong!");
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamSubQuestions(
      String qid) async* {
    yield* firestore
        .collection('question')
        .doc(qid)
        .collection('sub_question')
        .orderBy('create_at', descending: true)
        .limitToLast(5)
        .snapshots();
  }

  Future<void> editSubQuestion(String qid, String sqid) async {
    if (editSubQuestionC.text.isNotEmpty) {
      try {
        Map<String, dynamic> subData = {
          "question": editSubQuestionC.text,
        };
        isLoading.value = true;
        await firestore
            .collection('question')
            .doc(qid)
            .collection('sub_question')
            .doc(sqid)
            .update(subData);
        print(sqid);

        Get.back();

        Get.snackbar(
            "Berhasil!", "Anda berhasil mengubah sub pertanyaan survey");
      } catch (e) {
        Get.snackbar(
            "Terjadi kesalahan", "Anda tidak dapat mengubah sub question");
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Terjadi kesalahan", "Data yang di ubah tidak boleh kosong");
    }
  }

  void deleteSubQuestion(String questionId, String subQuestionId) async {
    try {
      isLoading.value = true;
      await firestore
          .collection('question')
          .doc(questionId)
          .collection('sub_question')
          .doc(subQuestionId)
          .delete();
      Get.snackbar("Berhasil", "Anda berhasil menghapus sub question");
    } catch (e) {
      Get.snackbar(
          "Terjadi kesalahan", "Anda tidak dapat menghapus sub question");
    } finally {
      isLoading.value = false;
    }
  }
}
