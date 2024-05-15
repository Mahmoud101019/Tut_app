// ignore_for_file: prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:tut_app/app/app.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/resourses/language_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(
    EasyLocalization(
      child: Phoenix(
        child: MyApp(),
      ),
      supportedLocales: [ARABIC_LOCAL, ENGLISH_LOCAL],
      path: ASSET_PATH_LOCALISATIONS,
    ),
  );
}
