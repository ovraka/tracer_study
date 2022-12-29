import 'package:get/get.dart';

import '../controllers/tracer_study_controller.dart';

class TracerStudyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TracerStudyController>(
      () => TracerStudyController(),
    );
  }
}
