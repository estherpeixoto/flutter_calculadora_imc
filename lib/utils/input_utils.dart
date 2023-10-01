class InputUtils {
  static double stringToDouble(String text) {
    if (text.contains(',')) {
      text = text.replaceAll('.', '');
      text = text.replaceAll(',', '.');
    }

    return double.parse(text);
  }
}
