import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resourses/strings_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.home),
    );
  }
}
