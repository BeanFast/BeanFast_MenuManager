import 'package:flutter/material.dart';

class TextDataTable extends StatelessWidget {
  final String data;
  final double width;
  final int maxLines;
  final Color tooltipBgColor;

  const TextDataTable(
      {super.key,
      required this.data,
      required this.width,
      required this.maxLines,
      required this.tooltipBgColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Tooltip(
        triggerMode: TooltipTriggerMode.tap,
        showDuration: const Duration(milliseconds: 0),
        message: data,
        decoration: BoxDecoration(
          color: tooltipBgColor,
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
