import 'package:get/get.dart';

import '../controllers/edit_question_controller.dart';

class EditQuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditQuestionController>(
      () => EditQuestionController(),
    );
  }
}
