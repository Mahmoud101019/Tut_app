import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/presentation/main/pages/home/view/home_view.dart';
import 'package:tut_app/presentation/main/pages/notifications/view/notifications_view.dart';
import 'package:tut_app/presentation/main/pages/search/view/search_view.dart';
import 'package:tut_app/presentation/main/pages/settings/view/settings_view.dart';
import 'package:tut_app/presentation/resourses/color_manager.dart';
import 'package:tut_app/presentation/resourses/strings_manager.dart';
import 'package:tut_app/presentation/resourses/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomeView(),
    const SearchView(),
    const NotificationsView(),
    const SettingsView()
  ];

  List<String> titlesList = [
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notifications.tr(),
    AppStrings.settings.tr(),
  ];
  var title = AppStrings.home.tr();
  var curnnetindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: AppSize.s0,
        // automaticallyImplyLeading: false,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: pages[curnnetindex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorManager.lightgrey,
              spreadRadius: AppSize.s0,
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: curnnetindex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: AppStrings.home.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: AppStrings.search.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.notifications),
              label: AppStrings.notifications.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: AppStrings.settings.tr(),
            ),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      curnnetindex = index;
      title = titlesList[index];
    });
  }
}
