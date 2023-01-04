import 'package:get/get.dart';

import '../controllers/detail_alumni_controller.dart';

class DetailAlumniBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailAlumniController>(
      () => DetailAlumniController(),
    );
  }
}
