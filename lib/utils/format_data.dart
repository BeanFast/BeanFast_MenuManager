import 'package:intl/intl.dart';

class Formatter {
  static String formatMoney(String value) {
    String result = value.split('.')[0];
    final f = NumberFormat("#,###", "vi_VN");
    int num = int.parse(result.replaceAll(f.symbols.GROUP_SEP, ''));
    final newString = '${f.format(num)} đ';
    return newString;
  }

  static String formatPoint(String value) {
    String result = value.split('.')[0];
    final f = NumberFormat("#,###", "vi_VN");
    int num = int.parse(result.replaceAll(f.symbols.GROUP_SEP, ''));
    final newString = '${f.format(num)} điểm';
    return newString;
  }

  static String formatPriceToString(String value) {
    final formattedValue = StringBuffer();
    for (int i = value.length - 1; i >= 0; i--) {
      if ((value.length - 1 - i) % 3 == 0 && i != value.length - 1) {
        formattedValue.write('.');
      }
      formattedValue.write(value[i]);
    }
    return formattedValue.toString().split('').reversed.join();
  }

  static double? formatPriceToDouble(String value) {
    return double.tryParse(value.replaceAll(RegExp(r'[^0-9]'), ''));
  }
}
