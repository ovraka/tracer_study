import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class QuestionsSurveyController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamListQuestion() async* {
    final questRef = fireStore.collection('question');
    final query = questRef.orderBy('create_at', descending: true).snapshots();
    yield* query;
  }

  void deleteQuestion(String qid) async {
    try {
      await fireStore.collection('question').doc(qid).delete();
    } catch (e) {
      Get.snackbar('Terjadi Kesalahan', 'Anda tidak dapat menghapus question');
    }
  }
}
