import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constants.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: color,
  fontFamily: GoogleFonts.poppins().fontFamily,
  textTheme: GoogleFonts.poppinsTextTheme(),
  appBarTheme: AppBarTheme(
    backgroundColor: color,
    titleTextStyle: GoogleFonts.poppins(),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
);

final darkTheme = ThemeData(
  scaffoldBackgroundColor: color,
  fontFamily: GoogleFonts.poppins().fontFamily,
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    displayColor: Colors.white,
    bodyColor: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: color,
    titleTextStyle: GoogleFonts.poppins(color: Colors.white),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  dividerTheme: const DividerThemeData(color: Colors.white),
);
