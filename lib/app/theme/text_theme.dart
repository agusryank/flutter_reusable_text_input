import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle gfont = GoogleFonts.getFont(
  "Open Sans",
  fontSize: 15.5,
  color: Colors.black87,
);

TextStyle gfontBold = GoogleFonts.getFont("Open Sans", fontSize: 15.5, color: Colors.black87, fontWeight: FontWeight.bold);

class Gfont {
  static final white = gfont.copyWith(color: Colors.white);
  static final orange = gfont.copyWith(color: Colors.orange);
  static final blue = gfont.copyWith(color: Colors.blue);
  static final blue2 = gfont.copyWith(color: Colors.blue);
  static final blue3 = gfont.copyWith(color: Colors.blue);
  static final red = gfont.copyWith(color: Colors.red);
  static final green = gfont.copyWith(color: Colors.green);
  static final black7 = gfont.copyWith(color: Colors.black87);
  static final black = gfont.copyWith(color: Colors.black);

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

  static final bold = gfontBold.copyWith(fontWeight: FontWeight.bold, color: Colors.black);
  static boldWith([Color color = Colors.black, double size = 15.5]) => gfontBold.copyWith(fontWeight: FontWeight.bold, color: color, fontSize: size);

  static final itallic = gfont.copyWith(fontStyle: FontStyle.italic, color: Colors.black87);
  static italicWith([Color color = Colors.black87, double size = 15.5]) => gfont.copyWith(fontStyle: FontStyle.italic, color: color, fontSize: size);
}
