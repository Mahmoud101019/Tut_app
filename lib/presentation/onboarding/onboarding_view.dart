import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tut_app/presentation/resourses/app_assets_manager.dart';
import 'package:tut_app/presentation/resourses/color_manager.dart';
import 'package:tut_app/presentation/resourses/strings_manager.dart';
import 'package:tut_app/presentation/resourses/values_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  late final List<Sliderobject> _list = _getsliderdata();
  int _curntpageindex = 0;
  List<Sliderobject> _getsliderdata() => [
        Sliderobject(
          title: AppStrings.onboardingtitle1,
          subtitle: AppStrings.onboardingsubtitle1,
          image: AppAssets.onboarding1,
        ),
        Sliderobject(
          title: AppStrings.onboardingtitle2,
          subtitle: AppStrings.onboardingsubtitle2,
          image: AppAssets.onboarding2,
        ),
        Sliderobject(
          title: AppStrings.onboardingtitle3,
          subtitle: AppStrings.onboardingsubtitle3,
          image: AppAssets.onboarding3,
        ),
        Sliderobject(
          title: AppStrings.onboardingtitle4,
          subtitle: AppStrings.onboardingsubtitle4,
          image: AppAssets.onboarding4,
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.dark),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _list.length,
        onPageChanged: (index) {
          setState(() {
            _curntpageindex = index;
          });
        },
        itemBuilder: (context, index) {
          return OnboardingPage(
            sliderobject: _list[index],
          );
        },
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        height: AppSize.s100,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  AppStrings.skip,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

class Sliderobject {
  String title;
  String subtitle;
  String image;

  Sliderobject({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}
