class Formatter {
  static String formatPrice(String value) {
    final formattedValue = StringBuffer();
    for (int i = 0; i < value.length; i++) {
      if (i % 3 == 0 && i != 0) {
        formattedValue.write('.');
      }
      formattedValue.write(value[i]);
    }
    return formattedValue.toString();
  }
}