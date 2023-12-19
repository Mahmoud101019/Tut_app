import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resourses/app_assets_manager.dart';
import 'package:tut_app/presentation/resourses/color_manager.dart';
import 'package:tut_app/presentation/resourses/consats_manager.dart';
import 'package:tut_app/presentation/resourses/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? timer;

  startdisplay() {
    timer = Timer(
      const Duration(seconds: AppConestans.splashdisplay),
      gonext,
    );
  }

  gonext() {
    Navigator.pushReplacementNamed(context, Routes.onboardingroute);
  }

  @override
  void initState() {
    super.initState();
    startdisplay();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.primary,
        body: Center(
          child: Image.asset(AppAssets.splashimage),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
