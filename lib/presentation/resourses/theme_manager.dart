import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resourses/color_manager.dart';
import 'package:tut_app/presentation/resourses/fonts_manager.dart';
import 'package:tut_app/presentation/resourses/style_manager.dart';
import 'package:tut_app/presentation/resourses/values_manager.dart';

ThemeData getThemeApp() {
  return ThemeData(
    //main theme
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightprimary,
    primaryColorDark: ColorManager.darkprimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightprimary,
    // card view theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),
    //app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.lightprimary,
      titleTextStyle: getRegularStyle(
        fontsize: FontSize.s16,
        color: ColorManager.white,
      ),
    ),
    //button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightprimary,
    ),
    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManager.white,
          fontsize: FontSize.s17,
        ),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),
    //tetx theme
    textTheme: TextTheme(
      displayLarge: getSemiboldStyle(
        color: ColorManager.darkgrey,
        fontsize: FontSize.s16,
      ),
      headlineMedium: getRegularStyle(
        color: ColorManager.darkgrey,
        fontsize: FontSize.s14,
      ),
      titleMedium: getmediumStyle(
        color: ColorManager.primary,
        fontsize: FontSize.s16,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.grey,
      ),
    ),
    //input decoration theme (Text Form Faild)

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(
        color: ColorManager.grey,
        fontsize: FontSize.s14,
      ),
      labelStyle: getmediumStyle(
        color: ColorManager.grey,
        fontsize: FontSize.s14,
      ),
      errorStyle: getRegularStyle(
        color: ColorManager.error,
      ),
      ////////////////////////////////////////
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey,
          width: AppSize.s2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      ////////////////////////////////////////
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      ////////////////////////////////////////
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      ////////////////////////////////////////
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
    ),
  );
}
