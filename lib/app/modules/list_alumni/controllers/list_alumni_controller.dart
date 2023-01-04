import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ListAlumniController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> listAlumni() async {
    final userRef = fireStore.collection('user');
    final query = userRef.where('role', isEqualTo: 'alumni').get();
    print(query);
    return await query;
  }
}
