import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logbook/shared/theme/main_colors.dart';

class TextStyles {
  static final title = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static final heading = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Colors.white70,
  );

  static final text = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white60
  );

  static final fieldText = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white60
  );

  static final drawer = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white70
  );
}