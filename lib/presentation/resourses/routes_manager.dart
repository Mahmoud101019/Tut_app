import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/forgetpassword/view/forgetpassword_view.dart';
import 'package:tut_app/presentation/login/view/login_view.dart';
import 'package:tut_app/presentation/main/main_view.dart';
import 'package:tut_app/presentation/onboarding/view/onboarding_view.dart';
import 'package:tut_app/presentation/resourses/strings_manager.dart';
import 'package:tut_app/presentation/signup/view/signup_view.dart';
import 'package:tut_app/presentation/splash/splash_view.dart';
import 'package:tut_app/presentation/storedetails/view/storedetails_view.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String onboardingroute = '/OnBoardingView';
  static const String forgetpasswordRoute = '/forgetpassword';
  static const String mainRoute = '/main';
  static const String storeDetailsRoute = '/storeDetails';
}

class RoutesGenerator {
  static Route<dynamic> getRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onboardingroute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.signupRoute:
        initSignUpModule();
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case Routes.forgetpasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.noRouteFound.tr()),
              ),
              body: Center(
                child: Text(AppStrings.noRouteFound.tr()),
              ),
            ));
  }
}
