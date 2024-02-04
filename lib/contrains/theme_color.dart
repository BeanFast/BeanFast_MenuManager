import 'package:flutter/material.dart';

class ThemeColor {
  // static Color m3BaseColor = const Color.fromRGBO(255, 225, 168, 1);
  // static Color appBarBgColor = const Color.fromRGBO(255, 219, 182, 1);
  // static Color primaryColor = const Color.fromRGBO(255, 204, 162, 1);
  // // static Color m3BaseColor = const Color.fromRGBO(255,183,151, 1);
  // // static Color m3BaseColor = const Color.fromRGBO(255,157,139, 1);
  // static Color cardBgColor = const Color.fromRGBO(255, 244, 233, 1);
  
  static Color bgColor = HexColor("#FFFFFF");
  static Color bgColor2 = HexColor('#F3FBF7');
  static Color bgColor3 = HexColor('#F5FFF6');
  static Color primaryColor = HexColor('#C3EBD7');
  static Color inputColor = HexColor('#26AA91');
  static Color textColor = HexColor('#070908');
  
}
Color HexColor(String hex) {
  final buffer = StringBuffer();
  if (hex.length == 6 || hex.length == 7) buffer.write('ff');
  buffer.write(hex.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
// #ffa256
// #ffb06f
// #ffbe89
// #ffcca2
// #ffdabc
// #ffe8d5
// #fff6ef