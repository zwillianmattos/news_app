import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(String)? onChanged;
  const SearchBarWidget(
      {super.key, required this.controller, this.label = 'Search...', this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      elevation: MaterialStateProperty.resolveWith<double?>(
          (Set<MaterialState> states) => 1.0),
      controller: controller,
      onChanged: onChanged,
    );
  }
}
