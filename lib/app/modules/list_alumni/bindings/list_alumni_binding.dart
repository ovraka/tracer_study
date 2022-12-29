import 'package:get/get.dart';

import '../controllers/list_alumni_controller.dart';

class ListAlumniBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListAlumniController>(
      () => ListAlumniController(),
    );
  }
}
