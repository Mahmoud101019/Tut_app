import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resourses/strings_manager.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.notifications),
    );
  }
}
