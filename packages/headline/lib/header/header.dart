
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String content;

  const Header({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Text(content);
  }
}