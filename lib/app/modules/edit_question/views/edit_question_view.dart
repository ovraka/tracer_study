import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/theme/colors.dart';
import '../../../data/theme/custom_widget.dart';
import '../controllers/edit_question_controller.dart';

class EditQuestionView extends GetView<EditQuestionController> {
  EditQuestionView({Key? key}) : super(key: key);
  final Map<String, dynamic> data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.questionC.text = data['question'];
    controller.categoryC.text = data['category'];

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: softNavy,
        title: Text("EDIT QUESTION",
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: softWhite))),
        centerTitle: true,
      ),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Text("Kategori Pertanyaan",
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: softNavy))),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: softWhite,
          ),
          child: TextField(
            enabled: false,
            controller: controller.categoryC,
            cursorColor: softNavy,
            autocorrect: false,
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: softNavy)),
            decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.arrow_drop_down),
                hintStyle: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: softGrey))),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text("Pertanyaan",
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: softNavy))),
        const SizedBox(
          height: 5,
        ),
        bigInputText(
          controller: controller.questionC,
          hintText: 'Masukkan pertanyaan',
        ),
        const SizedBox(
          height: 30,
        ),
        Obx(() => basicButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                controller.updateQuestion(data['uid']);
              }
            },
            buttonText:
                controller.isLoading.isFalse ? 'EDIT QUESTION' : 'Loading...'))
      ]),
    );
  }
}
