import 'package:flutter/material.dart';

class TextDataTable extends StatelessWidget {
  final String data;
  final double width;
  final int maxLines;

  const TextDataTable({
    super.key,
    required this.data,
    required this.width,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Tooltip(
        triggerMode: TooltipTriggerMode.tap,
        showDuration: const Duration(milliseconds: 0),
        message: data,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          data,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class TextFieldItem extends StatelessWidget {
  final String title;
  final String data;

  const TextFieldItem({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Wrap(
            children: [
              Text(title),
            ],
          ),
          Wrap(
            children: [
              Text(data),
            ],
          ),
          // Text(
          //   data,
          //   style: Get.theme.textTheme.bodyMedium,
          // ),
        ],
      ),
    );
  }
}
