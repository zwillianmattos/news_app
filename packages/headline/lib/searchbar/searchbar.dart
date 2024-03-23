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
          (Set<MaterialState> states) => 0.0),
      controller: controller,
      onChanged: onChanged,
      hintText: label,
      padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry?>(
          (Set<MaterialState> states) => const EdgeInsets.symmetric(horizontal: 16.0)),
      leading: const Icon(Icons.search, size: 24),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) =>Color.fromARGB(255, 221, 221, 221)),
    );
  }
}
