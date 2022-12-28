import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracer_study/app/data/theme/colors.dart';
import 'package:tracer_study/app/data/theme/custom_widget.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: softNavy,
          title: Text("SIGN UP",
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
            Text("NIM (Nomor Induk Mahasiswa)",
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
                controller: controller.nimC,
                hintText: '',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number),
            const SizedBox(
              height: 20,
            ),
            Text("NIK (Nomor Induk Kependudukan)",
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
                controller: controller.nikC,
                hintText: '',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number),
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
                readOnly: false,
                controller: controller.emailC,
                hintText: 'example@gmail.com',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress),
            const SizedBox(
              height: 20,
            ),
            Text("Jenis Kelamin",
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
                    items: controller.menuItems,
                    hint: Text('Pilih jenis kelamin',
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
                      controller.selectedGender.value = value.toString();
                    },
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Text("Tahun Lulus",
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
                controller: controller.graduateYearC,
                hintText: '',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number),
            const SizedBox(
              height: 30,
            ),
            Obx(() => basicButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.addNewUser();
                  }
                },
                buttonText: controller.isLoading.isFalse
                    ? 'Tambah Pegawai'
                    : 'Loading...'))
          ],
        ));
  }
}
