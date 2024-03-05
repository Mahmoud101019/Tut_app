import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resourses/strings_manager.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.search),
    );
  }
}
