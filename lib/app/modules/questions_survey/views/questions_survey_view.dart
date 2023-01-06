import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracer_study/app/routes/app_pages.dart';

import '../../../data/theme/colors.dart';
import '../controllers/questions_survey_controller.dart';

class QuestionsSurveyView extends GetView<QuestionsSurveyController> {
  const QuestionsSurveyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softWhite,
      appBar: AppBar(
        backgroundColor: softNavy,
        title: Text(
          "LIST QUESTION",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: softWhite),
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              cursorColor: softNavy,
              textInputAction: TextInputAction.search,
              keyboardType: TextInputType.name,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400, color: softNavy),
              ),
              decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: softGrey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: softWhite,
                  contentPadding: EdgeInsets.zero),
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamListQuestion(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(backgroundColor: softNavy),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
                return Center(
                  child: Text(
                    "Tidak ada data question",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        snapshot.data!.docs[index].data();
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                            flex: 2,
                            onPressed: (context) {
                              Get.toNamed(Routes.EDIT_QUESTION,
                                  arguments: data);
                            },
                            icon: Icons.edit,
                            backgroundColor: softNavy,
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              controller.deleteQuestion(data['uid']);
                            },
                            icon: Icons.delete,
                            backgroundColor: Colors.red,
                          ),
                        ],
                      ),
                      child: ListTile(
                          contentPadding: const EdgeInsets.all(20),
                          title: Text(
                            data['category'],
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: softNavy),
                            ),
                          ),
                          subtitle: Text(
                            data['question'],
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
                          leading: data['category'] ==
                                  "Masa TPB (Tahap Persiapan Bersama)"
                              ? const Icon(Icons.groups_outlined)
                              : data['category'] == "Internal Kampus"
                                  ? const Icon(Icons.location_city_rounded)
                                  : data['category'] == "Kompetensi"
                                      ? const Icon(Icons.menu_book_rounded)
                                      : data['category'] == "Pekerjaan" &&
                                              data['category'] ==
                                                  "Pekerjaan Utama: Bekerja" &&
                                              data['category'] ==
                                                  "Pekerjaan Utama" &&
                                              data['category'] ==
                                                  "Pekerjaan Utama: Wirausaha" &&
                                              data['category'] ==
                                                  "Pekerjaan Utama: Melanjutkan Studi" &&
                                              data['category'] ==
                                                  "Pekerjaan Utama: Tidak Bekerja"
                                          ? const Icon(Icons.work_rounded)
                                          : const SizedBox()),
                    );
                  });
            } else {
              return Center(
                child: Text(
                  "Tidak dapat memuat data",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                ),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: softNavy,
        child: const Icon(Icons.add),
        onPressed: () => Get.toNamed(Routes.ADD_QUESTION),
      ),
    );
  }
}
