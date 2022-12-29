import 'package:get/get.dart';

import '../controllers/questions_survey_controller.dart';

class QuestionsSurveyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionsSurveyController>(
      () => QuestionsSurveyController(),
    );
  }
}
