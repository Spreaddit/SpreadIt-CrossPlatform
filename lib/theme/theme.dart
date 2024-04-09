import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const redditOrange = Color.fromARGB(255, 14, 9, 7);
const redditBlack = Color(0x00000000);
const redditGrey = Color.fromRGBO(206, 227, 248, 1);

ThemeData spreadItTheme = ThemeData(
  fontFamily: GoogleFonts.notoSans().fontFamily,
  primaryColor: redditOrange,
  primaryColorLight: redditGrey,
  primaryColorDark: redditBlack,
  colorScheme: ColorScheme.fromSeed(
    seedColor: redditOrange,
    primary: redditOrange,
    secondary: redditGrey,
  ),
);
