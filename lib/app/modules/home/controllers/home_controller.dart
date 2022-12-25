import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  void logOut() async {
    await auth.signOut();
    Get.offAllNamed(Routes.HOME);
  }
}
