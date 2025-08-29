import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme{
  static ThemeData lightTheme(){
    return ThemeData.light().copyWith(
        textTheme: TextTheme(
          bodySmall: GoogleFonts.roboto(
            color: Colors.white,
          ),
          titleSmall: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        )
    );
  }
}

