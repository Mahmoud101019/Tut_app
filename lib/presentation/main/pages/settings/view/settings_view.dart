import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/data/data_source/local_data_source.dart';
import 'package:tut_app/presentation/resourses/app_assets_manager.dart';
import 'package:tut_app/presentation/resourses/routes_manager.dart';
import 'package:tut_app/presentation/resourses/strings_manager.dart';
import 'package:tut_app/presentation/resourses/values_manager.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final AppPreferences appPreferences = instance<AppPreferences>();
  final LocalDataSource localDataSource = instance<LocalDataSource>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p8),
        children: [
          ///////Change language///////

          ListTile(
            onTap: () {},
            leading: SvgPicture.asset(AppAssets.changeLanguage),
            title: Text(
              AppStrings.changeLanguage,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: SvgPicture.asset(AppAssets.arrowGoRight),
          ),

          ///////Contact Us///////

          ListTile(
            onTap: () {},
            leading: SvgPicture.asset(AppAssets.contactUs),
            title: Text(
              AppStrings.contactUs,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: SvgPicture.asset(AppAssets.arrowGoRight),
          ),

          /////Invite Your Friends//////

          ListTile(
            onTap: () {},
            leading: SvgPicture.asset(AppAssets.inviteFriends),
            title: Text(
              AppStrings.inviteYourFriends,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: SvgPicture.asset(AppAssets.arrowGoRight),
          ),

          ////Logout//////

          ListTile(
            onTap: () {
              logou();
            },
            leading: SvgPicture.asset(AppAssets.logout),
            title: Text(
              AppStrings.logout,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: SvgPicture.asset(AppAssets.arrowGoRight),
          ),
        ],
      ),
    );
  }

  logou() {
    //app prefs make that log out
    appPreferences.setUserLoggedOut();
    //clear cache
    localDataSource.clearCache();
    //navigator to login Screen
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
