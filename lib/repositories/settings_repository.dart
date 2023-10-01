import 'package:imc/models/settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  // Save settings
  static void save(SettingsModel settingsModel) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('height', settingsModel.height);
  }

  // Get settings
  static Future<SettingsModel> get() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final double? height = prefs.getDouble('height');

    if (height == null) {
      return SettingsModel.empty();
    }

    return SettingsModel(height);
  }
}
