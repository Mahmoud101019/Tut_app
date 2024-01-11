import 'package:flutter/material.dart';
import 'package:tut_app/presentation/forgetpassword/forgetpassword_view.dart';
import 'package:tut_app/presentation/login/view/login_view.dart';
import 'package:tut_app/presentation/main/main_view.dart';
import 'package:tut_app/presentation/onboarding/view/onboarding_view.dart';
import 'package:tut_app/presentation/resourses/strings_manager.dart';
import 'package:tut_app/presentation/signup/signup_view.dart';
import 'package:tut_app/presentation/splash/splash_view.dart';
import 'package:tut_app/presentation/storedetails/storedetails_view.dart';

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
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.signupRoute:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case Routes.forgetpasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(
                child: Text(AppStrings.noRouteFound),
              ),
            ));
  }
}
