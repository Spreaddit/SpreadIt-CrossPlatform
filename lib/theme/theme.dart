import 'package:flutter/material.dart';

const redditOrange = Color.fromARGB(255, 255, 68, 0);
const redditBlack = Color(0x00000000);
const redditGrey = Color.fromRGBO(206, 227, 248, 1);

ThemeData spreadItTheme = ThemeData(
    primaryColor: redditOrange,
    primaryColorLight: redditGrey,
    primaryColorDark: redditBlack,
    colorScheme: ColorScheme.fromSeed(
      seedColor: redditOrange,
      primary: redditOrange,
      secondary: redditGrey,
    ),);
