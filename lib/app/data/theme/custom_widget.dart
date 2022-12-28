import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracer_study/app/data/theme/colors.dart';

Widget inputText({
  required bool readOnly,
  required TextEditingController controller,
  required String hintText,
  required TextInputAction textInputAction,
  required TextInputType keyboardType,
}) {
  return Container(
    width: double.infinity,
    height: 50,
    padding: const EdgeInsets.only(left: 15, right: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: softWhite,
    ),
    child: TextField(
      readOnly: readOnly,
      controller: controller,
      cursorColor: softNavy,
      autocorrect: false,
      style: GoogleFonts.poppins(
          textStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: softNavy)),
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w400, color: softGrey))),
    ),
  );
}

Widget inputPassword({
  required TextEditingController controller,
  required RxBool obscureText,
  required Function() onPressed,
  required RxBool isPasswordHide,
  required String hintText,
}) {
  return Obx(() => Container(
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: softWhite,
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText.value,
          cursorColor: softNavy,
          autocorrect: false,
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w400, color: softNavy)),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                splashRadius: 1,
                onPressed: () {
                  isPasswordHide.toggle();
                },
                icon: Icon(
                  isPasswordHide.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: softGrey,
                ),
              ),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: softGrey))),
        ),
      ));
}

Widget basicButton(
    {required Function() onPressed, required String buttonText}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
    child: Ink(
      decoration: BoxDecoration(
          color: softNavy, borderRadius: BorderRadius.circular(5)),
      child: Container(
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        child: Text(
          buttonText,
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500)),
        ),
      ),
    ),
  );
}
