import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key, required this.search});
  final Function(String) search;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
        onChanged: (value) => search(value),
        decoration: const InputDecoration(
          labelText: 'Tìm kiếm',
        ),
        style: Get.theme.textTheme.bodyMedium,
      ),
    );
  }
}
