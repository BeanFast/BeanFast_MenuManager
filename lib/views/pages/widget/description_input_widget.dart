import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import '/contrains/theme_color.dart';

class DescriptionInput extends StatelessWidget {
  final QuillController quillController;
  const DescriptionInput({super.key, required this.quillController});

  @override
  Widget build(BuildContext context) {
    return
     Container(
      padding: const EdgeInsets.all(10),
      height: 150,
      width: Get.width - 20,
      decoration: BoxDecoration(
        border: Border.all(
          color: ThemeColor.inputColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: QuillEditor.basic(
        configurations: QuillEditorConfigurations(controller: quillController),
      ),
    );
  }
}
