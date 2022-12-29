import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mixins/mixins.dart';

TextStyle gfont = GoogleFonts.getFont(
  "Open Sans",
  fontSize: 15.5,
  color: C.black7,
);

TextStyle gfontBold = GoogleFonts.getFont("Open Sans",
    fontSize: 15.5, color: C.black7, fontWeight: FontWeight.bold);

class Gfont {
  static final white = gfont.copyWith(color: C.white);
  static final orange = gfont.copyWith(color: C.orange);
  static final blue = gfont.copyWith(color: C.blue);
  static final blue2 = gfont.copyWith(color: C.blue2);
  static final blue3 = gfont.copyWith(color: C.blue3);
  static final red = gfont.copyWith(color: C.red);
  static final green = gfont.copyWith(color: Colors.green);
  static final black3 = gfont.copyWith(color: C.black3);
  static final black4 = gfont.copyWith(color: C.black4);
  static final black5 = gfont.copyWith(color: C.black5);
  static final black6 = gfont.copyWith(color: C.black6);
  static final black7 = gfont.copyWith(color: C.black7);
  static final black = gfont.copyWith(color: C.black);

  // size
  static final fs13 = gfont.copyWith(fontSize: 13);
  static final fs14 = gfont.copyWith(fontSize: 14);
  static final fs15 = gfont.copyWith(fontSize: 15);
  static final fs16 = gfont.copyWith(fontSize: 16);
  static final fs17 = gfont.copyWith(fontSize: 17);
  static final fs18 = gfont.copyWith(fontSize: 18);
  static final fs19 = gfont.copyWith(fontSize: 19);
  static final fs20 = gfont.copyWith(fontSize: 20);
  static fs(dynamic size) => gfont.copyWith(fontSize: size);

  // color
  static color(Color color) => gfont.copyWith(color: color);

  static final bold =
      gfontBold.copyWith(fontWeight: FontWeight.bold, color: C.black);
  static boldWith([Color color = C.black, double size = 15.5]) => gfontBold
      .copyWith(fontWeight: FontWeight.bold, color: color, fontSize: size);

  static final itallic =
      gfont.copyWith(fontStyle: FontStyle.italic, color: C.black7);
  static italicWith([Color color = C.black7, double size = 15.5]) =>
      gfont.copyWith(fontStyle: FontStyle.italic, color: color, fontSize: size);
}
