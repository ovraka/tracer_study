import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  TextEditingController nimC = TextEditingController();
  TextEditingController nikC = TextEditingController();
  TextEditingController phoneNumberC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  TextEditingController genderC = TextEditingController();
  TextEditingController graduateYearC = TextEditingController();

  RxBool isLoading = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ImagePicker picker = ImagePicker();
  final storage = FirebaseStorage.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore.collection('user').doc(uid).snapshots();
  }

  XFile? image;
  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  void deleteProfilePicture(String uid) async {
    try {
      firestore.collection('user').doc(uid).update({
        "profile_picture": FieldValue.delete(),
      });
    } catch (e) {
      Get.snackbar(
          'Terjadi Kesalahan', 'Anda tidak dapat menghapus photo profile');
    } finally {
      update();
    }
  }

  Future<void> updateProfile(String uid) async {
    if (firstNameC.text.isNotEmpty &&
        lastNameC.text.isNotEmpty &&
        phoneNumberC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      try {
        Map<String, Object> data = {
          "first_name": firstNameC.text,
          "last_name": lastNameC.text,
          "phone_number": phoneNumberC.text,
        };
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;

          await storage.ref("$uid/profile_picture.$ext").putFile(file);

          String urlImage =
              await storage.ref("$uid/profile_picture.$ext").getDownloadURL();

          data.addAll({"profile_picture": urlImage});
        }
        isLoading.value = true;
        await firestore.collection('user').doc(uid).update(data);
        image = null;
        Get.snackbar('Berhasil!', 'Anda berhasil update profile');
      } catch (e) {
        Get.snackbar('Terjadi Kesalahan', 'Anda tidak dapat update profile');
      } finally {
        isLoading.value = false;
      }
    }
  }
}
