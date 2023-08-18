import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathfinder/utilities/consts/color_consts.dart';

class CustomTextStyles {
  TextStyle largeText({Color color = Colors.black}) {
    return GoogleFonts.aBeeZee(
        textStyle:
            TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: color,));
  }

  TextStyle header({Color color = Colors.black}) {
    return GoogleFonts.aBeeZee(
        textStyle:
            TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color));
  }

  TextStyle text({Color color = Colors.black}) {
    return GoogleFonts.aBeeZee(
        textStyle:
            TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: color));
  }
}
