import 'package:intl/intl.dart';

class SettingsModel {
  double height = 0.0;

  SettingsModel(this.height);

  SettingsModel.empty() {
    height = 0.0;
  }

  String getFormattedHeight() {
    final numberFormat = NumberFormat.currency(
        locale: 'pt_BR', symbol: ''); // @TODO internationalize it
    return numberFormat.format(height);
  }
}
