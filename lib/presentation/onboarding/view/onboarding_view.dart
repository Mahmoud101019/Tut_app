// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/presentation/onboarding/view_model/onboarding_viewmodel.dart';
import 'package:tut_app/presentation/resourses/app_assets_manager.dart';
import 'package:tut_app/presentation/resourses/color_manager.dart';
import 'package:tut_app/presentation/resourses/consats_manager.dart';
import 'package:tut_app/presentation/resourses/routes_manager.dart';
import 'package:tut_app/presentation/resourses/strings_manager.dart';
import 'package:tut_app/presentation/resourses/values_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();

  final OnBoardingViewModel _viewmodel = OnBoardingViewModel();

  final AppPreferences appPreferences = instance<AppPreferences>();

  _bind() {
    appPreferences.setOnBoardingScreenViewed();
    _viewmodel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewmodel.outputsliderviewobject,
      builder: (context, snapshot) {
        return _getContantWidget(snapshot.data);
      },
    );
  }

  Widget _getContantWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.white,
              statusBarBrightness: Brightness.dark),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: sliderViewObject.numberofslid,
          onPageChanged: (index) {
            _viewmodel.onchangepage(index);
          },
          itemBuilder: (context, index) {
            return OnboardingPage(
              sliderobject: sliderViewObject.sliderobject,
            );
          },
        ),
        bottomSheet: Container(
          color: ColorManager.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  },
                  child: Text(
                    AppStrings.skip,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              _getBottomSheet(sliderViewObject)
            ],
          ),
        ),
      );
    }
  }

  Widget _getBottomSheet(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //arrow Left
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  _viewmodel.goback(),
                  duration: const Duration(
                      microseconds: AppConestans.displayonboarding),
                  curve: Curves.bounceInOut,
                );
              },
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(AppAssets.arrowiconleft),
              ),
            ),
          ),
          //circle indecator
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numberofslid; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i, sliderViewObject.currentindex),
                ),
            ],
          ),
          //arrow Right
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  _viewmodel.gonext(),
                  duration: const Duration(
                      microseconds: AppConestans.displayonboarding),
                  curve: Curves.bounceInOut,
                );
              },
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(AppAssets.arrowiconright),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int curntpageindex) {
    if (index == curntpageindex) {
      return SvgPicture.asset(AppAssets.hollowCircle);
    } else {
      return SvgPicture.asset(AppAssets.solidCircle);
    }
  }

  @override
  void dispose() {
    _viewmodel.dispose();
    super.dispose();
  }
}

class OnboardingPage extends StatelessWidget {
  final Sliderobject sliderobject;
  const OnboardingPage({super.key, required this.sliderobject});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderobject.title,
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderobject.subtitle,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(sliderobject.image)
      ],
    );
  }
}
