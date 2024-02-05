import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '/utils/logger.dart';

class PickedDateView extends StatelessWidget {
  const PickedDateView({super.key, required this.label, required this.onTap});
  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    String initialValue = DateTime.now().toString();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        readOnly: true,
        initialValue: initialValue,
        decoration: InputDecoration(
          label: Text(label),
          prefixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () async {
          // FocusScope.of(Get.context!).requestFocus(FocusNode());
      
          // DateTime? pickedDate = await showDatePicker(
          //   context: Get.context!,
          //   initialDate: DateTime.now(),
          //   firstDate: DateTime(2000),
          //   lastDate: DateTime(2025),
          // );
      
          // if (pickedDate != null) {
          //   TimeOfDay? pickedTime = await showTimePicker(
          //     context: Get.context!,
          //     initialTime: TimeOfDay.now(),
          //   );
      
          //   if (pickedTime != null) {
          //     DateTime finalDateTime = DateTime(
          //       pickedDate.year,
          //       pickedDate.month,
          //       pickedDate.day,
          //       pickedTime.hour,
          //       pickedTime.minute,
          //     );
          //     logger.i(finalDateTime);
          //   }
          // }
        },
      ),
    );
  }
}
