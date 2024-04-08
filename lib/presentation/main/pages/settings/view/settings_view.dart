import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resourses/strings_manager.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.settings),
    );
  }
}
