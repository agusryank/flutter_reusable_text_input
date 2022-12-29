import 'package:flutter/material.dart';
import 'package:mixins/mixins.dart';

ThemeData appTheme = ThemeData(
  fontFamily: 'OpenSans',
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: C.red, size: 20),
  ),
  iconTheme: IconThemeData(color: C.red, size: 20),
  textTheme: TextTheme(
    bodyText2:
        TextStyle(fontSize: 15.5, fontFamily: 'OpenSans', color: C.black7),
  ),
);
