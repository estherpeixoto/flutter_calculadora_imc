class InputUtils {
  /// Tratar número no formato 0.000,00
  static double stringToDouble(String text) {
    if (text.contains(',')) {
      text = text.replaceAll('.', '');
      text = text.replaceAll(',', '.');
    }

    return double.parse(text);
  }
}