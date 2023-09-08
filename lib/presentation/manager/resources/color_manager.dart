import 'package:flutter/material.dart';

class Colormanager {
  // Predefined colors
  static Color black = Colors.black;
  static Color red = Colors.redAccent;
  static Color indigoAccent = Colors.indigoAccent;
  static Color primary = HexColor.fromHex("#ED9728");
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737 477");
  static Color lightGrey = HexColor.fromHex("#9E9E9e");
  static Color primaryOpacity70 = HexColor.fromHex("#B3ED9728");
  static Color darkPrimary = HexColor.fromHex("#d17d11");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#e61f34");
}

// Extension to convert hex color strings to Color objects.
extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    return Color(
      int.parse(hexColorString, radix: 16),
    );
  }
}