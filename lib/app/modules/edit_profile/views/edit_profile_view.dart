import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_cli/common/utils/json_serialize/json_ast/json_ast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracer_study/app/data/theme/custom_widget.dart';

import '../../../data/theme/colors.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: softNavy,
          title: Text("EDIT PROFILE",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: softWhite))),
          centerTitle: true,
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamUser(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snap.hasData) {
                Map<String, dynamic> user = snap.data!.data()!;
                controller.firstNameC.text = user['first_name'];
                controller.lastNameC.text = user['last_name'];
                controller.phoneNumberC.text = user['phone_number'];
                controller.emailC.text = user['email'];

                String defaultImage =
                    "https://ui-avatars.com/api/?name=${user["first_name"]}&&background=4d5d7e&color=f9fbfa&&size=200";
                return ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        GetBuilder<EditProfileController>(
                            builder: (controller) {
                          if (controller.image != null) {
                            return ClipOval(
                              child: SizedBox(
                                height: 120,
                                width: 120,
                                child: Image.file(
                                  File(controller.image!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          } else {
                            return ClipOval(
                              child: SizedBox(
                                height: 120,
                                width: 120,
                                child: Image.network(
                                  user["profile_picture"] != null
                                      ? user["profile_picture"] != ""
                                          ? user["profile_picture"]
                                          : defaultImage
                                      : defaultImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }
                        }),
                        Positioned(
                          top: -5,
                          left: 170,
                          child: MaterialButton(
                            height: 10,
                            onPressed: () {
                              controller.pickImage();
                            },
                            color: softGrey,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(5),
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    linkText(
                        onPressed: () {
                          controller.deleteProfilePicture(user["uid"]);
                        },
                        textButtonStyleFromSize: 14,
                        textStyleSize: 14,
                        color: softNavy,
                        text: 'Delete photo'),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Nama Depan",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: softNavy))),
                    const SizedBox(
                      height: 5,
                    ),
                    inputText(
                        readOnly: false,
                        controller: controller.firstNameC,
                        hintText: '',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Nama Belakang",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: softNavy))),
                    const SizedBox(
                      height: 5,
                    ),
                    inputText(
                        readOnly: false,
                        controller: controller.lastNameC,
                        hintText: '',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Nomor Telepon",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: softNavy))),
                    const SizedBox(
                      height: 5,
                    ),
                    inputText(
                        readOnly: false,
                        controller: controller.phoneNumberC,
                        hintText: '',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Email",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: softNavy))),
                    const SizedBox(
                      height: 5,
                    ),
                    inputText(
                        readOnly: true,
                        controller: controller.emailC,
                        hintText: 'example@gmail.com',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Obx(() => basicButton(
                        onPressed: () async {
                          if (controller.isLoading.isFalse) {
                            await controller.updateProfile(user["uid"]);
                          }
                        },
                        buttonText: controller.isLoading.isFalse
                            ? 'SIMPAN'
                            : 'Loading...'))
                  ],
                );
              } else {
                return Text("Tidak dapat memuat data",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: softNavy)));
              }
            }));
  }
}
