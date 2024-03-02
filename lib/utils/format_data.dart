class Formatter {
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