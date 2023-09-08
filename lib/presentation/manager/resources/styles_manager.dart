import 'package:flutter/material.dart';
import 'font_manager.dart';

// Function to get a TextStyle with specified font properties.
TextStyle _getTextStyle(
  double fontSize,
  String fontFamily,
  FontWeight fontWeight,
  Color color,
) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    color: color,
  );
}

//Regular Text Style
TextStyle getRegularStyle({
  double fontSize = FontSize.textSize12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.regular,
    color,
  );
}

//Light Text Style
TextStyle getLightStyle({
  double fontSize = FontSize.textSize12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.light,
    color,
  );
}

//Bold Text Style
TextStyle getBoldStyle({
  double fontSize = FontSize.textSize12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.bold,
    color,
  );
}

//Medium Text Style
TextStyle getMediumStyle({
  double fontSize = FontSize.textSize12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.medium,
    color,
  );
}

//Semi-Bold Text Style
TextStyle getSemiBoldStyle({
  double fontSize = FontSize.textSize12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.semiBold,
    color,
  );
}
