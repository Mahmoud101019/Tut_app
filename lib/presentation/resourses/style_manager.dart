import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resourses/fonts_manager.dart';

TextStyle _getTextStyle(double fontsize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontsize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: FontConstans.fontfamily);
}

// bold style
TextStyle getBoldStyle({
  double fontsize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontsize,
    FontWeightManager.bold,
    color,
  );
}

// Semibold style
TextStyle getSemiboldStyle({
  double fontsize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontsize,
    FontWeightManager.semiBold,
    color,
  );
}

// medium style
TextStyle getmediumStyle({
  double fontsize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontsize,
    FontWeightManager.medium,
    color,
  );
}

// regular style
TextStyle getRegularStyle({
  double fontsize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontsize,
    FontWeightManager.regular,
    color,
  );
}

// light style
TextStyle getlightStyle({
  double fontsize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontsize,
    FontWeightManager.light,
    color,
  );
}
