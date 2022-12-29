import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/questions_survey_controller.dart';

class QuestionsSurveyView extends GetView<QuestionsSurveyController> {
  const QuestionsSurveyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuestionsSurveyView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'QuestionsSurveyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
