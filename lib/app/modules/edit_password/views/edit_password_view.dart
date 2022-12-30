import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_password_controller.dart';

class EditPasswordView extends GetView<EditPasswordController> {
  const EditPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditPasswordView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'EditPasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
