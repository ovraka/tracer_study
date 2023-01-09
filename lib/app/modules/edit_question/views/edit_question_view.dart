import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/theme/colors.dart';
import '../../../data/theme/custom_widget.dart';
import '../../../routes/app_pages.dart';
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
                suffixIcon: const Icon(Icons.arrow_drop_down),
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
                controller.updateQuestion(data['qid']);
              }
            },
            buttonText:
                controller.isLoading.isFalse ? 'EDIT QUESTION' : 'Loading...')),
        const SizedBox(
          height: 20,
        ),
        TextButton.icon(
          // <-- TextButton
          onPressed: () {
            Get.defaultDialog(
              backgroundColor: Colors.grey[200],
              title: "Add New Sub Question",
              content: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Masukkan sub question baru",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          fontSize: 14,
                          color: softNavy,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: softWhite,
                      ),
                      child: TextField(
                        controller: controller.addNewSubQuestionC,
                        cursorColor: softNavy,
                        autocorrect: false,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: softNavy)),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '',
                            hintStyle: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: softGrey))),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              controller.isLoading.value = false;
                              Get.back();
                            },
                            child: Text(
                              "Batal",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                fontSize: 14,
                                color: softNavy,
                                fontWeight: FontWeight.w300,
                              )),
                            )),
                        Obx(() => TextButton(
                            onPressed: () async {
                              if (controller.isLoadingDialog.isFalse) {
                                controller.addNewSubQuestion(
                                    data['qid'], data['category']);
                              }
                              controller.isLoading.value = false;
                            },
                            child: Text(
                              controller.isLoadingDialog.isFalse
                                  ? 'Tambah'
                                  : 'Loading...',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                fontSize: 14,
                                color: softNavy,
                                fontWeight: FontWeight.w600,
                              )),
                            ))),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.add,
            size: 20.0,
            color: softNavy,
          ),
          style: TextButton.styleFrom(
            foregroundColor: softNavy,
          ),
          label: Text("Add new sub question",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: softNavy))),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Sub questions",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: softNavy)),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: softGrey,
              ),
              child: Text(
                "See more",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: softGrey)),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.streamSubQuestions(data['qid']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: softNavy),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
                  return SizedBox(
                    height: 150,
                    child: Center(
                      child: Text(
                        "Belum ada data sub question.",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      Map<String, dynamic> dataSub =
                          snapshot.data!.docs[index].data();

                      return Slidable(
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                flex: 2,
                                onPressed: (context) {
                                  controller.editSubQuestionC.text =
                                      dataSub['question'];
                                  Get.defaultDialog(
                                    backgroundColor: Colors.grey[200],
                                    title: "Edit Sub Question",
                                    content: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              "Masukkan sub question baru",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                fontSize: 14,
                                                color: softNavy,
                                                fontWeight: FontWeight.w600,
                                              )),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 50,
                                            padding: const EdgeInsets.only(
                                                left: 15, right: 15),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: softWhite,
                                            ),
                                            child: TextField(
                                              controller:
                                                  controller.editSubQuestionC,
                                              cursorColor: softNavy,
                                              autocorrect: false,
                                              style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: softNavy)),
                                              textInputAction:
                                                  TextInputAction.next,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '',
                                                  hintStyle: GoogleFonts.poppins(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  softGrey))),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    controller.isLoading.value =
                                                        false;
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    "Batal",
                                                    style: GoogleFonts.poppins(
                                                        textStyle:
                                                            const TextStyle(
                                                      fontSize: 14,
                                                      color: softNavy,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    )),
                                                  )),
                                              Obx(() => TextButton(
                                                  onPressed: () async {
                                                    if (controller
                                                        .isLoadingDialog
                                                        .isFalse) {
                                                      controller
                                                          .editSubQuestion(
                                                              data['qid'],
                                                              dataSub['sqid']);
                                                    }
                                                    controller.isLoading.value =
                                                        false;
                                                  },
                                                  child: Text(
                                                    controller.isLoadingDialog
                                                            .isFalse
                                                        ? 'Edit'
                                                        : 'Loading...',
                                                    style: GoogleFonts.poppins(
                                                        textStyle:
                                                            const TextStyle(
                                                      fontSize: 14,
                                                      color: softNavy,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )),
                                                  ))),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                icon: Icons.edit,
                                backgroundColor: softNavy,
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  controller.deleteSubQuestion(
                                      data['qid'], dataSub['sqid']);
                                },
                                icon: Icons.delete,
                                backgroundColor: Colors.red,
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            title: Text(
                              dataSub['question'],
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                              color: softGrey,
                            ),
                          ));
                    });
              } else {
                return Center(
                  child: Text(
                    "Tidak dapat memuat data",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                );
              }
            }),
      ]),
    );
  }
}
