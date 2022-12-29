import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracer_study/app/routes/app_pages.dart';

import '../../../data/theme/colors.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: softWhite,
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: controller.streamRole(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              Map<String, dynamic> user = snap.data!.data()!;
              return ListView(padding: EdgeInsets.zero, children: [
                UserAccountsDrawerHeader(
                  accountName: Text("Alumni Connect",
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: softWhite))),
                  accountEmail: Text("Universitas Saintek Muhammadiyah",
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: softWhite))),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/tracer-study-8c1a7.appspot.com/o/usm.png?alt=media&token=ccd139b7-7f57-4648-925a-13e9267c1dde',
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(color: softNavy),
                ),
                ListTile(
                  leading: const Icon(Icons.person, color: softNavy),
                  title: Text("Profile",
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: softNavy))),
                  onTap: () {
                    Get.toNamed(Routes.PROFILE);
                  },
                ),
                if (user["role"] == "alumni")
                  ListTile(
                    leading:
                        const Icon(Icons.list_alt_rounded, color: softNavy),
                    title: Text("Survey Tracer Study",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: softNavy))),
                    onTap: () {
                      Get.toNamed(Routes.TRACER_STUDY);
                    },
                  ),
                if (user["role"] == "operator")
                  ListTile(
                    leading:
                        const Icon(Icons.list_alt_rounded, color: softNavy),
                    title: Text("List Alumni",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: softNavy))),
                    onTap: () {
                      Get.toNamed(Routes.LIST_ALUMNI);
                    },
                  ),
                if (user["role"] == "operator")
                  ListTile(
                    leading: const Icon(Icons.question_mark_rounded,
                        color: softNavy),
                    title: Text("Questions Survey",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: softNavy))),
                    onTap: () {
                      Get.toNamed(Routes.QUESTIONS_SURVEY);
                    },
                  ),
                if (user["role"] == "operator")
                  ListTile(
                    leading: const Icon(Icons.person_add, color: softNavy),
                    title: Text("Create New Account",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: softNavy))),
                    onTap: () {
                      Get.toNamed(Routes.REGISTER);
                    },
                  ),
                ListTile(
                  leading: const Icon(Icons.settings, color: softNavy),
                  title: Text("Settings",
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: softNavy))),
                  onTap: () {
                    Get.toNamed(Routes.SETTINGS);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: softNavy),
                  title: Text("Logout",
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: softNavy))),
                  onTap: () {
                    controller.logOut();
                  },
                ),
              ]);
            }),
      ),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: softNavy,
        title: Text("ALUMNI CONNECT",
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: softWhite))),
        centerTitle: true,
      ),
      body: Center(),
    );
  }
}
