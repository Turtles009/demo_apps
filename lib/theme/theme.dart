import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  scaffoldBackgroundColor: color,
  fontFamily: GoogleFonts.poppins().fontFamily,
  textTheme: GoogleFonts.poppinsTextTheme(),
  appBarTheme: AppBarTheme(
    backgroundColor: color,
    titleTextStyle: GoogleFonts.poppins(),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
);

const color = Color(0xff5e7cec);
