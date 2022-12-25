import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/theme/custom_widget.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: IntrinsicHeight(
              child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                inputText(
                    readOnly: false,
                    controller: controller.nimC,
                    hintText: 'NIM',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number),
                const SizedBox(
                  height: 20,
                ),
                inputText(
                    readOnly: false,
                    controller: controller.nikC,
                    hintText: 'NIK',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number),
                const SizedBox(
                  height: 20,
                ),
                inputText(
                    readOnly: false,
                    controller: controller.firstNameC,
                    hintText: 'Nama Depan',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name),
                const SizedBox(
                  height: 20,
                ),
                inputText(
                    readOnly: false,
                    controller: controller.lastNameC,
                    hintText: 'Namka Belakang',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name),
                const SizedBox(
                  height: 20,
                ),
                inputText(
                    readOnly: false,
                    controller: controller.phoneNumberC,
                    hintText: 'Nomor Telepon',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number),
                const SizedBox(
                  height: 20,
                ),
                inputText(
                    readOnly: false,
                    controller: controller.emailC,
                    hintText: 'Email',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 20,
                ),
                inputText(
                    readOnly: false,
                    controller: controller.genderC,
                    hintText: 'Jenis Kelamin',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                inputText(
                    readOnly: false,
                    controller: controller.graduateYearC,
                    hintText: 'Tahun Lulus',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => gradientButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        await controller.addNewUser();
                      }
                    },
                    buttonText: controller.isLoading.isFalse
                        ? 'Tambah User'
                        : 'Loading...'))
              ],
            ),
          )),
        ),
      ),
    );
  }
}
