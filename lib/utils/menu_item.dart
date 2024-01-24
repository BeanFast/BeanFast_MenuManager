import 'package:flutter/material.dart';

class MenuItem {
  const MenuItem(
      {required this.title, required this.icon, required this.route});

  final String title;
  final IconData icon;
  final String route;
}