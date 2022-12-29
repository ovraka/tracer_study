import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tracer_study_controller.dart';

class TracerStudyView extends GetView<TracerStudyController> {
  const TracerStudyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TracerStudyView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TracerStudyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
