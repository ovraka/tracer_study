import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracer_study/app/routes/app_pages.dart';

import '../../../data/theme/colors.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: softNavy,
          title: Text("SETTINGS",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: softWhite))),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ListTile(
              onTap: () {
                Get.toNamed(Routes.EDIT_PROFILE);
              },
              leading: const Icon(
                Icons.person,
                color: softNavy,
              ),
              title: Text("Edit Profile",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: softNavy))),
            ),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.EDIT_PASSWORD);
              },
              leading: const Icon(
                Icons.vpn_key,
                color: softNavy,
              ),
              title: Text("Edit Password",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: softNavy))),
            ),
          ],
        ));
  }
}
