import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/theme/colors.dart';
import '../../../data/theme/custom_widget.dart';
import '../controllers/add_question_controller.dart';

class AddQuestionView extends GetView<AddQuestionController> {
  const AddQuestionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: softNavy,
        title: Text("CREATE NEW QUESTION",
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
        Obx(() => Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: DropdownButtonFormField2(
                items: controller.categoryItems,
                hint: Text('Pilih ketegori pertanyaan',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: softGrey))),
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none),
                dropdownDecoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                buttonHeight: 50,
                buttonPadding: const EdgeInsets.only(left: 0, right: 15),
                onChanged: (value) {
                  controller.defaultValueCategory.value = value.toString();
                },
              ),
            )),
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
                await controller.addNewQuestion();
              }
            },
            buttonText: controller.isLoading.isFalse
                ? 'CREATE QUESTION'
                : 'Loading...'))
      ]),
    );
  }
}
