import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InputDecoration inputDecoration(
    {required String labelText, required String hintText}) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: GoogleFonts.urbanist(
      color: const Color(0xFF95A1AC),
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    hintText: hintText,
    hintStyle: GoogleFonts.urbanist(
      color: const Color(0xFF95A1AC),
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0xFFE1EDF9),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0xFFE1EDF9),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0x00000000),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0x00000000),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    filled: true,
    fillColor: const Color(0xFFFFFFFF),
    contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
  );
}

TextStyle textStyle() {
  return GoogleFonts.urbanist(
    color: const Color(0xFF14181B),
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
}
