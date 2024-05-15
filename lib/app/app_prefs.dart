// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/presentation/resourses/language_manager.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED =
    "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";

class AppPreferences {
  final SharedPreferences sharedPreferences;
  AppPreferences({
    required this.sharedPreferences,
  });
  Future<String> getapplanguage() async {
    String? language = sharedPreferences.getString(PREFS_KEY_LANG);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getvalue();
    }
  }

  Future<void> changeAppLanguage() async {
    String currentLanguage = await getapplanguage();

    if (currentLanguage == LanguageType.ARABIC.getvalue()) {
      //set english
      sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.ENGLISH.getvalue());
    } else {
      // set arabic
      sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.ARABIC.getvalue());
    }
  }

  Future<Locale> getLocale() async {
    String currentLanguage = await getapplanguage();

    if (currentLanguage == LanguageType.ARABIC.getvalue()) {
      return ARABIC_LOCAL;
    } else {
      return ENGLISH_LOCAL;
    }
  }

  //onboarding Screen

  Future<void> setOnBoardingScreenViewed() async {
    sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED) ??
        false;
  }

  //Login Screen

  Future<void> setUserLoggedIn() async {
    sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }

  Future<void> setUserLoggedOut() async {
    sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
  }
}
