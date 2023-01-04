import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracer_study/app/routes/app_pages.dart';

import '../../../data/theme/colors.dart';
import '../controllers/list_alumni_controller.dart';

class ListAlumniView extends GetView<ListAlumniController> {
  const ListAlumniView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: softNavy,
        title: Text(
          "LIST ALUMNI",
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
      body: GetBuilder<ListAlumniController>(
        builder: (controller) => FutureBuilder(
          future: controller.listAlumni(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: softNavy),
              );
            }
            if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
              return Center(
                child: Text(
                  "Tidak ada data alumni",
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
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                Map<String, dynamic> data = snapshot.data!.docs[index].data();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Material(
                    borderRadius: BorderRadius.circular(5),
                    color: softWhite,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_ALUMNI, arguments: data);
                      },
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${data['first_name']} ${data['last_name']}"
                                  .toUpperCase(),
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: softNavy)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "NIM : ${data['nim']}",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: softNavy)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
